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

    var totalChkBoxes = $("#tblEmployeeDetails tr td input[type='checkbox']").length;
    var checkedChkBoxes = $("#tblEmployeeDetails tr td input[type='checkbox']:checked").length;
    if (totalChkBoxes == checkedChkBoxes) {
        $("input[id$='checkall']").attr("checked", true);
    }
    else {
        $("input[id$='checkall']").attr("checked", false);
    }

}

function dataTable() {
    oTable = $("#tblEmployeeDetails").dataTable();
}
function getEmployees() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "EmsWebMethods.aspx/getEmployees",
        data: "{'EmpNo':'" + $("#txtEmpId").val() + "','Department':'" + $("[id$='ddlDepartment']").val() + "','Shift':'" + $("[id$='ddlShifts']").val() + "'}",
        success: onsuccessgetEmployees
    });
    return false;
}
function onsuccessgetEmployees(msg) {    
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
    tbl += "<th style='white-space:nowrap; text-align:left;'>Shift</th>";
    tbl += "<th style='display:none'</th>";
    tbl += "</tr>";
    tbl += "</thead>";
    tbl += "<tbody>";
    for (var i = 0; i < data.Employee.length; i++) {
        tbl += "<td style='cursor:Pointer;' id='txtcheckbox' align='center' ><input type='checkbox' onclick='checkUnChkCheckAll();' id='txtcheckbox" + i + "'></td>";
        tbl += "<td style='text-align:left;'>" + data.Employee[i].employee_name + "</td>";
        tbl += "<td style='text-align:left;'>" + data.Employee[i].employee_number + "</td>";
        tbl += "<td style='text-align:left;'>" + data.Employee[i].designationName + "</td>";
        tbl += "<td style='text-align:left;'>" + data.Employee[i].departmentname + " </td>";
        tbl += "<td style='text-align:left;'>" + data.Employee[i].shift_name + " </td>";
        tbl += "<td style='display:none;'><span class='employee_id'>" + data.Employee[i].employee_id + "</span> </td>";
        tbl += "</tr>";
    }
    tbl += "</tbody>";
    tbl += "</table>";
    $("#tblEmployeeDetails").html(tbl);
    $("#tblEmployeeDetails").show();
    dataTable();
    return false;
}
function changeShift() {    
    var EmployeeId = "";
    $("#tblEmployeeDetails tr td input[type='checkbox']:checked").each(function () {               
        if ($(this).is(":checked")) {
            EmployeeId = EmployeeId + $.trim($(this).closest("tr").find(".employee_id").html()) + ",";
        }
    });
    var shiftId = $("[id$='ddlChangeShift']").val();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "EmsWebMethods.aspx/ChangeShift",
        data: "{'EmpId':'" + EmployeeId + "','ShiftId':'" + shiftId + "'}",
        success: onsuccessChangeShift
    });
}
function onsuccessChangeShift() {
    showSuccessMsg("Information saved successfully!");
    getEmployees();
    return false;
}

