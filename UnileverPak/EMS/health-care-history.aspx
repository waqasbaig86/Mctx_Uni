<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="health-care-history.aspx.cs" Inherits="EMS_health_care_history" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        input[type="text"] {
            /*background: transparent;*/
            border: none;
            border-bottom: 1px solid #95b6c7;
            border-radius: 0px;
            box-shadow: none;
            padding: 0px;
            width: 97%;
            font-size: 14px;
        }
    </style>
   
    <div style="padding:10px;">
        <table align="center" style="background-color:#fff; width: 90%">
            <tr>
                <td colspan="2" align="right" style="font-size: 10px;">KWL-OHC-F-001</td>
            </tr>
            <tr>
                <td colspan="2" align="center" style="font-size: 17px; text-decoration: underline">UNILEVER PAKISTAN LIMITED</td>
            </tr>
            <tr>
                <td colspan="2" align="center" style="font-size: 15px; text-decoration: underline; line-height: 35PX;">ANNUAL MEDICAL EXAMINATION</td>
            </tr>
            <tr>
                <td>Year:  <span style="text-decoration: underline;">
                    <script type="text/javascript">
                        var d = new Date(); document.write(d.getFullYear());
                    </script>
                </span>

                </td>
                <td align="right">Location: <span style="text-decoration: underline;">Tea Factory Khanewal</span></td>
            </tr>
            <tr>
                <td colspan="2" align="left" style="line-height: 35px;">Date: <span style="text-decoration: underline;">

                    <script type="text/javascript">  var today = new Date();
                        var dd = today.getDate();
                        var mm = today.getMonth() + 1;//January is 0!`

                        var yyyy = today.getFullYear();
                        if (dd < 10) { dd = '0' + dd }
                        if (mm < 10) { mm = '0' + mm }
                        var today = dd + '/' + mm + '/' + yyyy;
                        document.write(today);
                    </script>
                </span></td>
            </tr>
            <tr>
                <td colspan="2">
                    <table style="width: 100%;">
                        <tr>
                                 <td style="width: 5%; vertical-align: bottom;">Emp.No.</td>
                            <td style="width: 26%; padding-left: 6px;">
                                <input type="text" id="TxtEmpno" runat="server"  onblur="getEmployeeInfo();" /></td>

                            <td style="width: 4%; vertical-align: bottom;">Name:</td>
                            <td align="left" style="width: 47%; padding-left: 3px;">
                                <input type="text" id="TxtName" runat="server" />

                            </td>

                            <td style="width: 4%; vertical-align: bottom;">Dept.</td>
                            <td style="width: 27%;">
                                <input type="text" id="TxtDept" runat="server" /></td>

                       
                        </tr>
                    </table>

                </td>

            </tr>

            <tr style="line-height: 3">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td>DOB:</td>
                            <td style="width: 29%;">
                                <input type="text" id="TxtDob" runat="server" /></td>
                            <td style="width: 23%;">&nbsp;</td>
                            <td>DOA:</td>
                            <td>
                                <input type="text" id="TxtDoa" runat="server" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold;  width: 15%;">Family History:</td>
                            <td>HTN</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtHtn" runat="server" /></td>
                            <td>IHD</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtIhd" runat="server" /></td>
                            <td>DM</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtDm" runat="server" /></td>
                            <td>Asthma</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtAsthma" runat="server" /></td>
                            <td>Other</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtOther" runat="server" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 3">
                <td style="text-decoration: underline; font-weight: bold; width: 27%;">Personal Medical & Surgical history:
                </td>
                <td align="right" style="padding-right: 5px;">
                    <input type="text" id="TxtHistory" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold;  width: 15%;">Chronic disease:</td>
                            <td>HTN</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtHtn1" runat="server" /></td>
                            <td>IHD</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtIhn1" runat="server" /></td>
                            <td>DM</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtDm1" runat="server" /></td>
                            <td>Asthma</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtAsthma1" runat="server" /></td>
                            <td>Other</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtOther1" runat="server" /></td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr style="line-height: 3">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold; padding-right: 30px; width: 15%;">Personal Habits:</td>
                            <td>Smoking</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtSmoking" runat="server" /></td>
                            <td style="width: 12%;">Substance abuse</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtAbuse" runat="server" /></td>
                            <td>Exercise</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtExercise" runat="server" /></td>
                            <td>Stress</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtStress" runat="server" /></td>

                        </tr>
                    </table>
                </td>
            </tr>

            <tr>


                <td style="text-decoration: underline; font-weight: bold; ">General Physcial Examination:</td>


                <td>
                    <table style="width:100%;">
                        <tr>

                            <td>Build</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtBuild" runat="server" /></td>
                            <td>Weight</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtWeight" runat="server" /></td>
                            <td>Height</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtHeight" runat="server" /></td>
                            <td>BMI</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtBmi" runat="server" /></td>
                            <td>Waist</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtWasit" runat="server" /></td>
                            <td>BP</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtBp" runat="server" /></td>
                            <td>Pulse</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtPulse" runat="server" /></td>

                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 3">

                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td>Oral Cavity</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtOral" runat="server" /></td>
                            <td>Thyroid</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtThyroid" runat="server" /></td>
                            <td>Skin</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtSkin" runat="server" /></td>
                            <td>Vision</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="TxtVision" runat="server" /></td>

                        </tr>

                    </table>
                </td>

            </tr>
            <tr>
  
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                          <td style="width:21%;">Other / Any specific deformity:</td>
                <td style="padding-left: 5px;">
                    <input type="text" id="TxtDefomity" runat="server" />
                </td>
                        </tr>
                    </table>
                
                </td>
            </tr>
            <tr style="line-height: 3">

                <td colspan="2" style="text-decoration: underline; font-weight: bold; padding-right: 30px;">Systemic Examination:</td>
            </tr>
            <tr style="line-height: 2">

                            <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                          <td>GIT:</td>
                <td style="padding-left: 5px;width:100%">
                    <input type="text" id="TxtGIT" runat="server" />
                </td>
                        </tr>
                    </table>
                
                </td>
            </tr>
            <tr style="line-height: 2">
                        <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                          <td>CVS:</td>
                <td style="padding-left: 5px;width:100%">
                    <input type="text" id="TxtCVS" runat="server" />
                </td>
                        </tr>
                    </table>
                
                </td>
            </tr>
            <tr style="line-height: 2">
                       <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                          <td>Respiratory:</td>
                <td style="padding-left: 5px;width:100%">
                    <input type="text" id="txtRespiratory" runat="server" />
                </td>
                        </tr>
                    </table>
                
                </td>
            </tr>
            <tr style="line-height: 2">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                          <td>CNS:</td>
                <td style="padding-left: 5px;width:100%">
                    <input type="text" id="txtCNS" runat="server" />
                </td>
                        </tr>
                    </table>
                
                </td>
            </tr>

<tr style="line-height: 3">

                <td colspan="2" style="text-decoration: underline; font-weight: bold; padding-right: 30px;">Laboratory Investigations:</td>
            </tr>
            <tr style="line-height: 0">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td>Hb%</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtHb" runat="server" /></td>
                            <td>ERS</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtERS" runat="server" /></td>
                            <td>TLC</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtTLC" runat="server" /></td>
                            <td>Platelets</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtPlatelets" runat="server" /></td>
                            <td>FBS</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtFBS" runat="server" /></td>
                            <td style="width:7%;">Uric Acid</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtUricAcid" runat="server" /></td>
                          
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 3">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td>Urine DR</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtUrineDR" runat="server" /></td>
                            <td>Blood Group</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtBloodGroup" runat="server" /></td>
                            <td>HBs Ag</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtHBs" runat="server" /></td>
                            <td>Anti HCV</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtAntiHCV" runat="server" /></td>
                            <td>S. Urea</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtUrea" runat="server" /></td>
                                                      
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 1.5">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td>S.Creatinine</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtCreatinine" runat="server" /></td>
                            <td>S.Bilirubin</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtBilirubin" runat="server" /></td>
                            <td>SGPT</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtSGPT" runat="server" /></td>
                            <td>S.Cholesterol</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtCholesterol" runat="server" /></td>
                            <td>TGD</td>
                            <td style="padding-left: 5px;">
                                <input type="text" id="txtTGD" runat="server" /></td>
                                                      
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 3">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td style="width:15%">Miscellaneous:- ECG</td>
                            <td style="padding-left: 5px;width:40%;">
                                <input type="text" id="txtECG" runat="server" /></td>
                            <td style="width:3%">CXR</td>
                            <td style="padding-left: 5px;width:40%;">
                                <input type="text" id="txtCXR" runat="server" /></td>
                           
                                                      
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 1.5">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td style="width:1%">Adiometry</td>
                            <td style="padding-left: 5px;width:40%;">
                                <input type="text" id="txtAdiometry" runat="server" /></td>
                            <td style="width:3%">Others</td>
                            <td style="padding-left: 5px;width:40%;">
                                <input type="text" id="txtMOthers" runat="server" /></td>
                           
                                                      
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 3">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold; padding-right: 5px;">Vaccinations:</td>
                            <td>History</td>
                            <td style="padding-left: 5px;width:100%">
                                <input type="text" id="txtVHistory" runat="server" /></td>
                        </tr>
                    </table>
                </td>     
            </tr>
            <tr style="line-height: 1.5">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>

                            <td style="width:4%">Tetanus</td>
                            <td style="padding-left: 5px;width:30%;">
                                <input type="text" id="txtVTetanus" runat="server" /></td>
                            <td style="width:3%">Typhoid</td>
                            <td style="padding-left: 5px;width:30%;">
                                <input type="text" id="txtVTyphoid" runat="server" /></td>
                             <td style="width:3%">Others</td>
                           <td style="padding-left: 5px;width:30%;">
                                <input type="text" id="txtVOthers" runat="server" /></td>
                                                      
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="line-height: 3">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold ;width:14%;">Current Medication:</td>
                          
                            <td style="padding-left: 5px;width:85%">
                                <input type="text" id="txtCurrentMedication" runat="server" /></td>
                        </tr>
                    </table>
                </td>     
            </tr>
            <tr style="line-height: 1.5">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold ;width:14%;">Remarks / Advice:</td>
                          
                            <td style="padding-left: 5px;width:85%">
                                <input type="text" id="txtRemarks" runat="server" /></td>
                        </tr>
                    </table>
                </td>     
            </tr>
            <tr style="line-height: 8">
                <td colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td>_________________ <br /><br /></td>                                                  
                        </tr>
                        <tr>
                            <td style="text-decoration: underline; font-weight: bold ;">Remarks / Advice:</td>
                        </tr>
                    </table>
                </td>     
            </tr>
            <tr style="line-height: 0">
          <td colspan="2"
                style="text-decoration: underline; font-weight: bold ;">Remarks / Advice:</>  
          </td>
      </tr>
            <tr>
               
                
                 <td colspan="2">
                     <input type="button" value="Save" id="btn" onclick="saveHealthInfo()" />
                 </td>
                
            </tr>
    </div>
    <asp:HiddenField ID="hdnHealthId" Value="0" runat="server" />
    <script type="text/javascript">
        function getEmployeeInfo() {
            debugger;
            var Empno = $("input[id$='TxtEmpno']").val();
            if (Empno != "") { 
 
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "health-care-history.aspx/getEmployeeInfo",
                        data: "{'Empno':'" + Empno + "'}",
                        success: onsuccessGetEmployeeInfoResult,
                        error: onErrorGetEmployeeInfoResult
                    });
                    return false;
                }
                else
                    return false;           
        }

        function onsuccessGetEmployeeInfoResult(msg) {
            debugger;
            var data = msg.d;
           
            alert(data.tbl_employeeResult.employee_name);
            $("input[id$='TxtName']").val(data.tbl_employeeResult.employee_name);
          
           
        }

        function onErrorGetEmployeeInfoResult() {


        }

    </script>
    <script src="HealthInfo.js"></script>
</asp:Content>

