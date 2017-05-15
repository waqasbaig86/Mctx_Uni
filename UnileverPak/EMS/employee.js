var oTable;
$(document).ready(function () {
    $('#divEmployeeEducationDetails').hide();
});
function openinformation(information) {
    var i;
    var x = document.getElementsByClassName("TypeOfInformation");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }

    document.getElementById(information).style.display = "block";
    getemployeeId();
}

//------------------------------For Picture ------------------------------------------------------------

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
function uploadStarted() {
    $get("imgDisplay").style.display = "none";
}
function uploadComplete2(sender, args) {

    //var a = $("input[id$='txtimangeName']").val();
    //alert(a+ "ha ja" )

    var name = readCookie("tabs").replace("url=", "");
    //alert(name + " Kuch nai bhai");
    var imgDisplay = $get("imgDisplay");
    imgDisplay.src = "../images/loader.gif";
    imgDisplay.style.cssText = "";
    var img = new Image();
    img.onload = function () {
        imgDisplay.style.cssText = "height:100px;width:100px";
        imgDisplay.src = img.src;
    };

    $("#divdummyClass").removeClass("dummy");


    img.src = "<%=ResolveUrl(UploadFolderPath) %>" + name + ".jpg";// args.get_fileName();
    $("input[id$='hdnPictureId']").val(name);

}

//-----------------------------------------End picture-----------------------------------------------------
function dataTable() {
    oTable = $("#tblEmployeeEducationDetails").dataTable();
}

function ShowDetails_Modal(EID, elm, flag) {
    editEmployees(EID, elm, flag);
}
function CloseModal() {    
    $("#fieldsetForm").jqmHide();
    $(".jqmWindow input, select").attr("disabled", false);
    return false;
}

function ClearEmployee() {
    $("div[id*='AsyncFileUpload1']").css("width", "400px");
    $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
    $("input[id*='AsyncFileUpload1']").val("");
    $("input[id*='AsyncFileUpload1']").css("background-color", "");
    $("input[id$='hdnPictureId']").val("");
    $("img[id$='imgDisplay']").hide();
    $("#dummy").addClass("dummy");
    $("#Personal input[type=text]").val("");
    $("#Personal select").val("");

    $("[id$='txtEmpID']").val("");

}
function addNewEmployee() {
    $("#Personal").show();
    $('#fieldsetForm').css("margin-left", "0%");
    $('#fieldsetForm').css("width", "97%");
    $('#trClose').hide();
    $("img[src$='btn_close02.png']").hide();
    $("input[id$='btnSaveEmployee']").show();
    $("div[id*='AsyncFileUpload1']").show();
    $(".jqmWindow input, select").attr("disabled", false);
    $("img[src$='Calendar.gif']").show();
    $('#fieldsetForm').removeClass("jqmWindow");

    $("div[id*='AsyncFileUpload1']").css("width", "400px");
    $("input[id*='AsyncFileUpload1']").val("");
    $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
    $("input[id*='AsyncFileUpload1']").css("background-color", "");
    $("input[id$='hdnPictureId']").val("");
    $("img[id$='imgDisplay']").hide();
    $("#divdummyClass").addClass("dummy");
    $("#fieldsetForm").show();
    $("#fieldsetGrd").hide();

    $("#tblEmployee input[type=text]").val("");
    $("input[id$='hdnPictureId']").val("")
    $("#tblEmployee select").val("");
}
function saveAcademic(flag) {
    $('#divEmployeeEducationDetails').show();
    myflag = flag;
    // getemployeeId();
    var employeeId = $.trim($("[id$='txtEmpAcdId']").val()) == "" ? 0 : $.trim($("[id$='txtEmpAcdId']").val());
    var AcademicData = "{"
    + "'employeeid':'" + employeeId + "',"
    + "'Quailification':'" + $.trim($("[id$='ddlQualification']").val()) + "',"
    + "'YearOfCompletion':'" + $.trim($("[id$='ddlCompletionYear']").val()) + "',"
    + "'Grade':'" + $.trim($("[id$='txtGradeCgpa']").val()) + "',"
    + "'Percentage':'" + $.trim($("[id$='txtPercentage']").val()) + "',"
    + "'School':'" + $.trim($("[id$='txtSchoolUniversity']").val()) + "'"
        + "}";
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "EmsWebMethods.aspx/saveAcedmic",
        data: AcademicData,
        success: onsuccessSaveAcademic,
        error: onretrieveSaveAcademicError
    });
    return false;
}
function onsuccessSaveAcademic() {

    $("#divSuccessMsg").show();
    $("#divSuccessMsg").html("");
    $("#divSuccessMsg").html("Record Successfully Saved!");
    $("#divSuccessMsg").fadeOut(6000);
    getEducation();
    if (myflag == "1") {
        myflag = "";
        openinformation('Finance')

    }
    //  $("#txtEmpAcdId").val("");
    // location.reload();
}
function onretrieveSaveAcademicError(err) {

    alert(err.responseText);
}

function getEducation() {
    //alert("heloo")
    var Employee_Edu_Id = $("input[id$='txtEmpAcdId']").val().trim();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "EmsWebMethods.aspx/getEmployeeEducation",
        data: "{'Employee_Edu_Id':'" + Employee_Edu_Id + "'}",
        success: onsuccessgetEmployeeEducation,
        error: onretrievegetEmployeeEducation
    });
    return false;
}
function onsuccessgetEmployeeEducation(msg) {

    var data = msg.d;
    if (oTable != null) {
        oTable.fnClearTable();
        oTable.fnDestroy();
    }
    var tbl = "";
    tbl += "<thead>";
    tbl += "<tr>";
    tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
    tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
    tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Education ID</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Education ID</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Qualification</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Id</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Year Of Completion</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Grade/Cgpa</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Percentage</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>School/University</th>";
    tbl += "</tr>";
    tbl += "</thead>";
    tbl += "<tbody>";
    for (var i = 0; i < data.EmployeeEducation.length; i++) {
        tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
        tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteEmployeeEducationRecord(" + i + ");'> </td>";
        tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
        tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EmployeeEducation[i].Employee_Edu_Id + "</td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEducationId" + i + "'>" + data.EmployeeEducation[i].EducationId + "</td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEducationName" + i + "'>" + data.EmployeeEducation[i].EducationName + "</td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmployeeId" + i + "'>" + data.EmployeeEducation[i].Employee_Id + "</td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtYearOfCompletion" + i + "'>" + data.EmployeeEducation[i].yearofcompletion + "</td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtGradeCgpa" + i + "'>" + data.EmployeeEducation[i].Grade_Cgpa + " </td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPercentage" + i + "'>" + data.EmployeeEducation[i].Percentage + " </td>";
        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtSchool_Uni" + i + "'>" + data.EmployeeEducation[i].School_Uni + " </td>";
        tbl += "</tr>";
    }
    tbl += "</tbody>";
    tbl += "</table>";
    $("#tblEmployeeEducationDetails").html(tbl);
    dataTable();
    return false;
}
function onretrievegetEmployeeEducation() {
    alert("Error In Loading Details!");
    return false;
}
function getRowID(rowID) {
    $("table[id$='tblEmployeeEducationDetails'] tr").css("background-color", "white");
    $("#trmain" + rowID).css("background-color", "#6798c1");

}
function DeleteEmployeeEducationRecord(rowNo) {

    var Employee_Education_ID = $("#txtID" + rowNo).html();

    if (confirm("Are you sure you wish to delete this Record?")) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "EmsWebMethods.aspx/DeleteEmployeeEducation",
            data: "{'Employee_Education_ID':'" + Employee_Education_ID + "'}",
            success: onsuccessDeleteData,
            error: onerror
        });

        return false;
    }
    else
        return false;
}

function onerror(xhr) {
    $(".alert").html(xhr.responseText);

}
function onsuccessDeleteData(msg) {
    //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
    showSuccessMsg("Record deleted successfully!");
    getEducation();
    return false;
}
function EditRecord(rowNo) {
    var Employee_ID = $("#txtEmployeeId" + rowNo).html().trim();
    $("input[id$='txtEmpAcdId']").val(Employee_ID);

    var Employee_Education_Id = $("#txtID" + rowNo).html().trim();
    $("input[id$='txtEmpEduAcdId']").val(Employee_Education_Id);
    var Employee_Qualification = $("#txtEducationId" + rowNo).html().trim();
    $("select[id$='ddlQualification']").val(Employee_Qualification);
    var Employee_Completion_year = $("#txtYearOfCompletion" + rowNo).html().trim();
    $("select[id$='ddlCompletionYear']").val(Employee_Completion_year);
    var Employee_Cgpa_Grade = $("#txtGradeCgpa" + rowNo).html().trim();
    $("input[id$='txtGradeCgpa']").val(Employee_Cgpa_Grade);
    var Employee_Percentage = $("#txtPercentage" + rowNo).html().trim();
    $("input[id$='txtPercentage']").val(Employee_Percentage);
    var Employee_School_Uni = $("#txtSchool_Uni" + rowNo).html().trim();
    $("input[id$='txtSchoolUniversity']").val(Employee_School_Uni);

    $("input[id$='btnUpdate']").show();
    $("input[id$='btnSave']").attr("disabled", true);
    return false;
}
function UpdateEmployeeEducation() {
    if (!validate("tblEmployeeEducationDetails")) {
        var Employee_ID = $("input[id$='txtEmpEduAcdId']").val();
        var Employee_Education_Id = $("input[id$='txtEmpAcdId']").val();
        var Employee_Qualification = $("select[id$='ddlQualification']").val();
        var Employee_CompletionYear = $("select[id$='ddlCompletionYear']").val();
        var Employee_Cgpa_Grade = $("input[id$='txtGradeCgpa']").val();
        var Employee_Percentage = $("input[id$='txtPercentage']").val();
        var Employee_School_Uni = $("input[id$='txtSchoolUniversity']").val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "EmsWebMethods.aspx/UpdateEmployeeEducation",
            data: "{'Employee_Education_Id':'" + Employee_Education_Id + "','Employee_Qualification':'" + Employee_Qualification + "','Employee_CompletionYear':'" + Employee_CompletionYear + "','Employee_Cgpa_Grade':'" + Employee_Cgpa_Grade + "','Employee_Percentage':'" + Employee_Percentage + "','Employee_School_Uni':'" + Employee_School_Uni + "'}",
            success: onsuccessUpdateEmployeeEducation
        });
    }
    return false;
}
function onsuccessUpdateEmployeeEducation() {
    //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
    showSuccessMsg("Record Updated successfully!");
    //$("input[id$='txtCityName']").val("");
    getEducation();



    return false;
}
function AddNewEducation() {
    $('#txtGradeCgpa').val("");
    $('#txtPercentage').val("");
    $('#txtSchoolUniversity').val("");
    // $('#ddlQualification').val("");
    // $('#ddlCompletionYear').val("");


    // $("#tblacdamic input[type=text]").val("");
    $("#tblacdamic select").val("");
}


var myflag = "";
function saveEmployee(flag) {
    //alert(flag) 
    myflag = flag;
    var employeeId = $.trim($("[id$='txtId']").val()) == "" ? 0 : $.trim($("[id$='txtId']").val());

    if ($("input[id$='hdnPictureId']").val().indexOf(":") >= 0) {
        $("input[id$='hdnPictureId']").val("");

    }

    var EmpData = "{"
            + "'employeeId':'" + employeeId + "',"
            + "'EmployeeName':'" + $.trim($("[id$='txtEmployeeName']").val()) + "',"
            + "'EmployeeNo':'" + $.trim($("[id$='txtEmployeeNo']").val()) + "',"
            + "'FatherName':'" + $.trim($("[id$='txtFatherName']").val()) + "',"
            + "'EmployeeCNIC':'" + $.trim($("[id$='txtCnic']").val()) + "',"
            + "'EmployeeAddress':'" + $.trim($("[id$='txtEmployeeAddress']").val()) + "',"
            + "'EmployeePhoneNo':'" + $.trim($("[id$='txtPhoneNo']").val()) + "',"
            + "'EmployeeMobile':'" + $.trim($("[id$='txtMobileNo']").val()) + "',"
            + "'EmployeeEmail':'" + $.trim($("[id$='txtEmail']").val()) + "',"
            + "'Gender':'" + $.trim($("[id$='ddlGender']").val()) + "',"
            + "'EmployeeCity':'" + $.trim($("[id$='ddlcity']").val()) + "',"
            + "'Employee_Dob':'" + $.trim($("[id$='txtEmployeeDob']").val()) + "',"
            + "'Employee_Status':'" + $.trim($("[id$='txtEmployeeStatus']").val()) + "',"
            + "'Religion':'" + $.trim($("[id$='ddlReligionid']").val()) + "',"
            + "'Sectt':'" + $.trim($("[id$='ddlSectt']").val()) + "',"
            + "'Caste':'" + $.trim($("[id$='ddlCaste']").val()) + "',"
            + "'BloddGroup':'" + $.trim($("[id$='ddlBloodGroup']").val()) + "',"            
            + "'EmployeeReporting':'" + $.trim($("[id$='ddlEmployeeReporting']").val()) + "',"
            + "'Department':'" + $.trim($("[id$='ddlDepartment']").val()) + "',"
            + "'Designation':'" + $.trim($("[id$='ddlDesignation']").val()) + "',"            
            + "'Shift':'" + $.trim($("[id$='ddlShift']").val()) + "',"
            + "'Photo':'" + $.trim($("[id$='hdnPictureId']").val()) + "',"
            + "'Quailification':'" + $.trim($("[id$='ddlQualification']").val()) + "',"
            + "'Employer':'" + $.trim($("[id$='ddlEmployer']").val()) + "',"            
              + "'AccountNo':'" + $.trim($("[id$='txtAccountNo']").val()) + "',"
              + "'NtnNo':'" + $.trim($("[id$='txtNtnNo']").val()) + "',"
              + "'EobiNo':'" + $.trim($("[id$='txtEobiNo']").val()) + "',"
              + "'Bank':'" + $.trim($("[id$='ddlBank']").val()) + "'"

            + "}";
    
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "EmsWebMethods.aspx/SaveEmployee",
        data: EmpData,
        success: function() {
            
            $("#divSuccessMsg").show();
            $("#divSuccessMsg").html("");
            $("#divSuccessMsg").html("Record Successfully Saved!");
            $("#divSuccessMsg").fadeOut(6000);
            ClearEmployee();
            if(employeeId!="0")
            {
                getEmployee();
                $("#Personal").hide();
                $("#divEmployeeSearch").show();
            }
        },
        error: onretrieveSaveEmployeeError
    });
    return false;
}


function onretrieveSaveEmployeeError(err) {    
    alert(err.responseText);
}
function getEmployee() {
    $("div[id*='addemployee']").hide();
    $("#fieldsetGrd").show();
    $("#fieldsetForm").hide();
    $("#tbodyEmployee").html("");
    $.post("../EMS/CallBack/EmployeeHandler.aspx", { Name: $("#txtNameSearch").val() }).done(function (data) {
        var response = data;
        var start = data.indexOf("#StartEmployee#") + 16;
        var end = data.indexOf("#EndEmployee#");
        $("#tbodyEmployee").html(response.substring(start, end));

        if ($("#tbodyEmployee tr").length == 0) {
            $("#tbodyEmployee").html("<tr><td class='noRecordFound' colspan='19'>No Record Found</td></tr>");
        }
    });

}
function editEmployees(eid, elm, flag) {

    if (flag == '1') {
        //alert("testdjdjjdjd")
        $('#fieldsetForm').addClass("jqmWindow");
        $(".jqmWindow input, select").attr("disabled", true);
        $("img[src$='Calendar.gif']").hide();
        $('#fieldsetForm').css("margin-left", "-44%");
        $('#fieldsetForm').css("width", "86%");
        $('#trClose').show();
        $("img[src$='btn_close02.png']").show();
        $("input[id$='btnSaveEmployee']").hide();
        $("div[id*='AsyncFileUpload1']").hide();
        $('#fieldsetForm').jqm({ modal: true, overlay: 75, trigger: false });
        $('#fieldsetForm').jqmShow();
    }
    else {
        $('#fieldsetForm').css("margin-left", "0%");
        $('#fieldsetForm').css("width", "97%");
        $('#trClose').hide();
        $("img[src$='btn_close02.png']").hide();        
        $("div[id*='AsyncFileUpload1']").show();
        $(".jqmWindow input, select").attr("disabled", false);
        $("img[src$='Calendar.gif']").show();
        $('#fieldsetForm').removeClass("jqmWindow");
    }
    $("div[id*='AsyncFileUpload1']").css("width", "400px");
    $("input[id*='AsyncFileUpload1']").val("");
    $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
    $("input[id*='AsyncFileUpload1']").css("background-color", "");
    $("input[id$='hdnPictureId']").val("");
    $("img[id$='imgDisplay']").hide();
    $("#divdummyClass").addClass("dummy");

    $("[id$='txtEmpID']").val("");

    $("#fieldsetForm input[type=text]").val("");
    $("#fieldsetForm select").val("");
    $("[id$='txtId']").val("0");
    $("#fieldsetForm").show();

    $("[id$='txtId']").val(eid);
    $("[id$='txtEmployeeNo']").val($.trim($(elm).closest("tr").find(".empNo").html()));
    $("[id$='txtEmployeeName']").val($.trim($(elm).closest("tr").find(".Name").html()));
    $("[id$='txtFatherName']").val($.trim($(elm).closest("tr").find(".fName").html()));
    $("[id$='txtEmployeeAddress']").val($.trim($(elm).closest("tr").find(".address").html()));
    $("[id$='txtPhoneNo']").val($.trim($(elm).closest("tr").find(".phone").html()));
    $("[id$='txtCnic']").val($.trim($(elm).closest("tr").find(".cnic").html()));
    $("[id$='txtMobileNo']").val($.trim($(elm).closest("tr").find(".cellno").html()));
    $("[id$='txtEmployeeStatus']").val($.trim($(elm).closest("tr").find(".status").html()));
    $("[id$='txtPhone']").val($.trim($(elm).closest("tr").find(".phone").html()));
    $("[id$='txtEmail']").val($.trim($(elm).closest("tr").find(".email").html()));
    $("[id$='ddlcity']").val($.trim($(elm).closest("tr").find(".cityid").html()));
    $("[id$='ddlGender']").val($.trim($(elm).closest("tr").find(".Genderid").html()));
    $("[id$='txtEmployeeDob']").val($.trim($(elm).closest("tr").find(".dob").html()));
    $("[id$='ddlReligionid']").val($.trim($(elm).closest("tr").find(".religionid").html()));
    $("[id$='ddlSectt']").val($.trim($(elm).closest("tr").find(".Secttid").html()));
    $("[id$='ddlCaste']").val($.trim($(elm).closest("tr").find(".Castid").html()));    
    $("[id$='ddlBloodGroup']").val($.trim($(elm).closest("tr").find(".Bloddgroupid").html()));
    $("[id$='ddlEducation']").val($.trim($(elm).closest("tr").find(".Educationid").html()));
    $("[id$='ddlEmployeeReporting']").val($.trim($(elm).closest("tr").find(".EmployeeReportedid").html()));
    $("#trReporting").hide();
    $("[id$='ddlDepartment']").val($.trim($(elm).closest("tr").find(".Departmentid").html()));
    $("[id$='ddlDesignation']").val($.trim($(elm).closest("tr").find(".Designationid").html()));
    $("[id$='ddlShift']").val($.trim($(elm).closest("tr").find(".Shiftid").html()));
    $("[id$='ddlEmployeeReporting']").val($.trim($(elm).closest("tr").find(".EmployeeReportedid").html()));
    $("[id$='ddlQualification']").val($.trim($(elm).closest("tr").find(".education_id").html()));
    $("[id$='ddlEmployer']").val($.trim($(elm).closest("tr").find(".Employer_Id").html()));
    $("[id$='ddlGender']").val($.trim($(elm).closest("tr").find(".GenderId").html()));
    $("[id$='ddlReligionid']").val($.trim($(elm).closest("tr").find(".religionid").html()));

    $("[id$='txtEmpFinId']").val($.trim($(elm).closest("tr").find(".Finance_info_id").html()));
    $("[id$='txtAccountNo']").val($.trim($(elm).closest("tr").find(".Account_No").html()));
    $("[id$='txtEobiNo']").val($.trim($(elm).closest("tr").find(".Eobi_No").html()));
    $("[id$='txtNtnNo']").val($.trim($(elm).closest("tr").find(".Ntn_no").html()));
    $("[id$='ddlBank']").val($.trim($(elm).closest("tr").find(".Select_Bank").html()));


    var str = $(elm).closest("tr").find(".phto img").attr("src");

    var last = str.substring(str.lastIndexOf("/") + 1, str.length);

    if (last.split('.')[0] != "") {
        $("#imgDisplay").attr("src", str);
        $("input[id$='hdnPictureId']").val(last.split('.')[0])
        $("#imgDisplay").show();
        $("#divdummyClass").removeClass("dummy");
    }
    else {
        $("#imgDisplay").hide();
        $("#divdummyClass").addClass("dummy");
    }

    $("#Personal").show();
    $("#divEmployeeSearch").hide();
}
function getemployeeId() {


    // var Employee_ID = $("select[id$='ddlemployeename']").val().trim();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "EmsWebMethods.aspx/getEmployeeId",
        data: {},
        success: onsuccessEmployeeId
    });
    return false;
}
function onsuccessEmployeeId(msg) {
    var data = msg.d;
    $("input[id$='txtEmpFinId']").val(data.RetrieveEmployeeId[0].employee_id);
    $("input[id$='txtEmpAcdId']").val(data.RetrieveEmployeeId[0].employee_id);
}
function addMedicalDetail(id) {
    window.open("../EMS/health-care-history.aspx?EmpId=" + id, "_blank");
}