var oTable;
$(document).ajaxStart(blockUI).ajaxStop(unblockUI);

function blockUI() {
    $.blockUI({
        message: '<img src="images/ajax-loader.gif" />',
        css: { borderStyle: 'none', backgroundColor: "Transparent" }
    });
}
function unblockUI() {
    $.unblockUI();
}
$(document).ready(function () {
    $("input[id$='checkall']").click(function () {
        if ($(this).is(":checked")) {
            $("input[id*='txtcheckbox']").attr("checked", true);
        }
        else {
            $("input[id*='txtcheckbox']").attr("checked", false);
        }
    });


});

function checkUnChkCheckAll() {

    var totalChkBoxes = $("#tblHierarchyDetails tr td input[type='checkbox']").length;
    var checkedChkBoxes = $("#tblHierarchyDetails tr td input[type='checkbox']:checked").length;
    if (totalChkBoxes == checkedChkBoxes) {
        $("input[id$='checkall']").attr("checked", true);
    }
    else {
        $("input[id$='checkall']").attr("checked", false);
    }

}

function dataTable() {
    oTable = $("#tblHierarchyDetails").dataTable();
}
function getHierarchy() {    
    var type = 'Assigned';
    if ($("input[id$='rbUnAssignedPerson']").is(":checked"))
        type = "Unassigned";            

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "HMSwebmethods.aspx/getHeirarchy",
        data: "{'EmployeeId':'" + $("select[id$='ddlReportingPerson']").val() + "','Type':'" + type + "'}",
        success: onsuccessgetHierarchy
    });
    return false;
}
function onsuccessgetHierarchy(msg) {
    var data = msg.d;
    if (oTable != null) {
        oTable.fnClearTable();
        oTable.fnDestroy();
    }

    var tbl = "";
    tbl += "<thead>";
    tbl += "<tr>";
    tbl += "<th style='text-align:left; white-space:nowrap;'>Select</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Employee No</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Designation Name</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Department Name</th>";
    tbl += "<th style='white-space:nowrap; text-align:left;'>Reporting Person Name</th>";
    tbl += "<th style='display:none'</th>";
    tbl += "</tr>";
    tbl += "</thead>";
    tbl += "<tbody>";
    for (var i = 0; i < data.Heirarchy.length; i++) {
        
        tbl += "<td style='cursor:Pointer;' id='txtcheckbox' align='center' ><input type='checkbox' onclick='checkUnChkCheckAll();' id='txtcheckbox" + i + "'></td>";
        tbl += "<td style='text-align:left;'>" + data.Heirarchy[i].employee_name + "</td>";
        tbl += "<td style='text-align:left;'>" + data.Heirarchy[i].employee_number + "</td>";
        tbl += "<td style='text-align:left;'>" + data.Heirarchy[i].designationName + "</td>";
        tbl += "<td style='text-align:left;'>" + data.Heirarchy[i].departmentname + " </td>";
        tbl += "<td style='text-align:left; white-space:nowrap; '>" + data.Heirarchy[i].reportingPersonName + " </td>";
        tbl += "<td style='display:none;'><span class='employee_id'>" + data.Heirarchy[i].employee_id + "</span> </td>";
        tbl += "</tr>";
    }
    tbl += "</tbody>";
    tbl += "</table>";
    $("#tblHierarchyDetails").html(tbl);
    $("#tblHierarchyDetails").show();
    dataTable();
    return false;
}
function updateReportingPerson() {
    var EmpId = "";
    $("#tblHierarchyDetails tr td input[type='checkbox']:checked").each(function () {        
        if ($(this).is(":checked")) {            
            EmpId = EmpId + $.trim($(this).closest("tr").find(".employee_id").html()) + ",";
        }
    });
    var Reporting_Id = $("select[id$='ddlChangeReportingPerson']").val().trim();
    if (Reporting_Id != "") {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "HMSwebmethods.aspx/UpdateHierarchy",
            data: "{'EmployeeId':'" + EmpId + "','ReportingId':'" + Reporting_Id + "','DateFrom':'" + $("[id$='txtDateFrom']").val() + "','DateTo':'" + $("[id$='txtDateTo']").val() + "','MainReporting':'" + $("[id$='chkMainReporting']").is(":checked") + "'}",
            success: onsuccessUpdateHeirarchy
        });
    }
}
function onsuccessUpdateHeirarchy() {
    showSuccessMsg("Record Updated successfully!");
    $("select[id$='ddlChangeReportingPerson']").val("");
    getHierarchy();
    return false;
}

function AssignedPerson() {
    $("#lblAssignedPerson").show();
    $("#ddlReporting").show();
    $("#tblHierarchyDetails").html("");
}
function UnassignPerson() {

    $("#lblAssignedPerson").hide();
    $("#ddlReporting").hide();
    $("#tblHierarchyDetails").html("");

}