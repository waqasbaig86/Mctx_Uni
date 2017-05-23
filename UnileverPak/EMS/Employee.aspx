<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Employee.aspx.cs" Inherits="EMS_Employee" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <link href="../css/jquery-ui.min.css" rel="stylesheet" />
    <script src="../js/jquery-ui.min.js"></script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="divEmployeeSearch">
        <fieldset>
            <legend>Employee Search Criteria</legend>
            <table class="form">
                <tr>
                    <td>Name:</td>
                    <td>
                        <input type="text" id="txtNameSearch" style="margin-left: -1050px; width: 250px;" />
                    </td>
                    <td colspan="2" style="text-align: center;">
                        <input type="button" style="margin-left: -1430px;" id="btnSearch" class="btn" value="Search" onclick="getEmployee();" />
                        <%--<input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />--%>
                    </td>
                </tr>
            </table>
        </fieldset>

        <div style="padding: 10px;">
            <input type="button" id="btnAddNew" class="btn" value="Add Employee" onclick="addNewEmployee();" />
        </div>

        <fieldset id="fieldsetGrd" style="width: 97%;">
            <legend>Employee</legend>
            <div style="padding-bottom: 20px;">
                <table class="dataTable">
                    <thead>
                        <tr>
                            <th style="width: 25px;">Edit</th>
                            <th style="width: 25px;">Health Info</th>
                            <th>Emp/Token No.</th>
                            <th>Name</th>
                            <th>Department</th>
                            <th>Designation</th>
                            <th>Shift</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Mobile</th>
                            <th>DOB</th>
                            <th>Gender</th>
                            <th>Photo</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyEmployee" style="background-color: white;">
                        <tr>
                            <td colspan="19">&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </div>
  
    
        
      <div id="Personal" class="TypeOfInformation" style="display: none">
          <div style="height:500px;overflow-y:auto">
        <fieldset id="fieldsetForm">
            <legend>Personal</legend>
            <table id="tblEmployee" class="form">
                <tr id="trClose">
                    <td style="text-align: right; border: none">
                        <div id="close">
                            <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent; border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px; cursor: pointer; right: 434px; left: 98%;"
                                alt="Close" onclick='return CloseModal();' />
                        </div>
                    </td>
                </tr>
                <tr style="line-height: 12px;">
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtId" disabled="disabled" />
                    </td>

                    <td colspan="2" rowspan="4" style="text-align:center;">
                        <div>
                            <cc1:AsyncFileUpload OnClientUploadComplete="uploadComplete2" runat="server" ID="AsyncFileUpload1"
        Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
        ThrobberID="imgLoader"  OnUploadedComplete="FileUploadComplete" ToolTip="Click Here"   OnClientUploadStarted = "uploadStarted"/> 
                            <asp:HiddenField ID="hdnPictureId" runat="server" />
                            <asp:Image ID="imgLoader" runat="server" ImageUrl="../images/loader.gif" /><br />
                            <br />
                        </div>
                        <div class="dummy" id="divdummyClass" style="margin: 0 auto;">
                            <img id="imgDisplay" alt="" src="" style="display: none; height: 100px; width: 100px;" />
                        </div>
                    </td>

                </tr>
                <tr>
                    <td class="right">Employee/Token No:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtEmployeeNo" class="req  numeric" />
                    </td>
                </tr>
                <tr>

                    <td class="right">Employee Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtEmployeeName" class="req" />
                    </td>
                </tr>

                <tr>
                    <td class="right">Father Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFatherName" class="req" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Phone No:</td>
                    <td>
                        <input type="text" id="txtPhoneNo" class="phone" />
                    </td>

                </tr>
                <tr>
                    <td class="right">CNIC:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtCnic" class="req cnic" />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">Mobile No:<span class="reqSpan">*</span></td>
                    <td style="width: 30%;">
                        <input type="text" id="txtMobileNo" class="cell req" />
                    </td>
                    <td class="right" style="width: 20%;">Email:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtEmail" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Employee Address:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtEmployeeAddress" class="req" />
                    </td>
                    <td class="right">Gender:</td>
                    <td>
                        <asp:DropDownList ID="ddlGender" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">City:</td>
                    <td>
                        <asp:DropDownList ID="ddlcity" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Religion:</td>
                    <td>
                        <asp:DropDownList ID="ddlReligionid" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">Sectt:</td>
                    <td>
                        <asp:DropDownList ID="ddlSectt" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Caste:</td>
                    <td>
                        <asp:DropDownList ID="ddlCaste" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">Blood Group:</td>
                    <td>
                        <asp:DropDownList ID="ddlBloodGroup" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Shift:</td>
                    <td>
                        <asp:DropDownList ID="ddlShift" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">Employee DOB:</td>
                    <td style="width: 30%;">

                        <asp:TextBox ID="txtEmployeeDob" CssClass="date disable_past_dates" runat="server" Style="width: 60%; float: left; margin-right: 5px;"></asp:TextBox>
                        <rjs:PopCalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtEmployeeDob" runat="server"
                            Font-Names="Tahoma" />
                        <%--   To-Today="true"--%>
                    </td>
                    <td class="right">Employee Status:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlJobStatus" class="req" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">Desigantion:</td>
                    <td>
                        <asp:DropDownList ID="ddlDesignation" runat="server" class="req">
                        </asp:DropDownList>
                    </td>

                    <td class="right">Department:</td>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>

                    <td class="right">Qualification:</td>
                    <td>
                        <asp:DropDownList ID="ddlQualification" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Employee Category:</td>
                    <td>
                        <asp:DropDownList ID="ddlEmployeeCategory" runat="server" class="req">
                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                            <asp:ListItem Text="Officer" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Staff" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="trReporting">
                    <td class="right">Employee Reporting:</td>
                    <td>
                        <asp:DropDownList ID="ddlEmployeeReporting" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Company/Employer:</td>
                    <td>
                        <asp:DropDownList ID="ddlEmployer" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>

        </fieldset>

        <%--/////////////////////-------DIV OF ACADEMIC--------/////////////////////////////////////////////////////////////////////--%>

        <%--<fieldset id="fieldsetacdamic">
                <legend>Academic Detail</legend>
          <table id="tblacdamic" >
              <tr>
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtEmpAcdId" disabled="disabled"  />
                    </td>

                  <td class="right">Education Id:</td>
                    <td>
                        <input type="text" id="txtEmpEduAcdId" disabled="disabled"  />
                    </td>
                  
                        </tr>
              <tr>
                  <td class="right">Qualification:</td>
                    <td>
                        <asp:DropDownList ID="ddlQualification" runat="server" class="req">                        
                    </asp:DropDownList>
                    </td>
                    <td class="right">Year Of Completion:</td>
                    <td>
                        <asp:DropDownList ID="ddlCompletionYear" runat="server" class="req">                        
                    </asp:DropDownList>
                    </td>
              </tr>
              <tr>
                  <td class="right"  style="width: 20%;">Grade/CGPA:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtGradeCgpa"  />                        
                    </td>                    
                    <td class="right"  style="width: 20%;">Percentage:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtPercentage"  />
                    </td>
              </tr>
              <tr>
                  <td class="right"  style="width: 20%;">School/University:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtSchoolUniversity"  />                        
                    </td>         
                  
              </tr>
              
          </table>
                <div style="margin-top:20px;margin-left:300px">
                    <input type="button" class="btn"  onclick="saveAcademic('0');" value="Save" />
                    <input type="button" class="btn"  onclick="AddNewEducation();" value="Add New Education" />
                    <input type="button" class="btn"  onclick="saveAcademic('1');" value="Save & Continue" />
                    <input type="button" class="btn"  onclick="UpdateEmployeeEducation();" value="Update" />
                </div>
                <div style="overflow: auto; width: 100%;">
                 <table id="tblEmployeeEducationDetails" style="background-color:white" >
                 </table>
                </div>
                </fieldset>--%>
        <%--//---------------------------Finance Information----------------------------%>
        <fieldset id="fieldsetFinance">
            <legend>Finance Information</legend>
            <table>
                <tr style="display:none">
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtEmpFinId" readonly="true" />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">Account No:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtAccountNo" />
                    </td>
                    <td class="right" style="width: 20%;">NTN No:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtNtnNo" />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">EOBI No:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtEobiNo" />
                    </td>
                    <td class="right">Select Bank:</td>
                    <td>
                        <asp:DropDownList ID="ddlBank" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                </tr>

            </table>

        </fieldset>
        </div>
    
    <div id="divButtons" class="btn-wrapper" style="padding-top: 20px;">
        <input type="button" id="btnSaveEmployee" class="btn" value="Save" onclick="saveEmployee('0');" />
        <%--<input type="button" id="btnSaveAndContinueEmployee" class="btn" value="Save and Continue" onclick="saveEmployee('1');" />--%>
        <asp:TextBox ID="txtEmpID" runat="server" Style="display: none;"></asp:TextBox>
        <input type="button" id="btnClearemployee" class="btn" value="New" onclick="ClearEmployee();" />

        <input type="button" id="btnBack" class="btn" value="Back" onclick="backEmployeeClick();" />
    </div>
    </div>

    <script src="employee.js"></script>
</asp:Content>

