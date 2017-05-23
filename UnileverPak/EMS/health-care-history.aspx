<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="health-care-history.aspx.cs" Inherits="EMS_health_care_history" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

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
            width: 100%;
            font-size: 14px;
        }
        
    </style>
    <div class="wrapper">
        <div class="wrapper-content">

            <div style="float: right; width: 99%; text-align: right; padding-right: 1%;">KWL-OHC-F-001</div>
            <div class="center main-heading1">UNILEVER PAKISTAN LIMITED</div>
            <div class="center main-heading2">ANNUAL MEDICAL EXAMINATION</div>    
               
            <div class="float">
                Year:
                <script type="text/javascript">
                    var d = new Date(); document.write(d.getFullYear());
                </script>
            </div>
            <div class="float" style="text-align:right;">Location:Tea Factory Khanewal</div>
               
            <div style="clear:both;">
                   <div class="sub-heading"> Personal Information:</div>
                <table style="width: 100%">
                    <tr>
                        <td class="right-align" style="width: 10%;">
                            <label>Emp.No:</label></td>
                        <td style="width: 22%;">
                            <input type="text" id="TxtEmpno" runat="server" class="font-bold" onblur="getEmployeeInfo();" /></td>
                        <td class="right-align" style="width: 10%;">
                            <label>Name:</label></td>
                        <td style="width: 22%;">
                            <input type="text" id="TxtName" class="font-bold" runat="server" /></td>
                        <td class="right-align" style="width: 10%;">
                            <label>Department</label></td>
                        <td style="width: 23%;">
                            <input type="text" id="TxtDept" class="font-bold" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>DOB:</label></td>
                        <td>
                            <input type="text" id="TxtDob" class="font-bold" runat="server" /></td>
                        <td class="right-align">
                            <label>DOA:</label></td>
                        <td>
                            <asp:TextBox ID="TxtDoa" CssClass="date" runat="server" Style="width: 60%; float: left; margin-right: 5px;"></asp:TextBox>
                            <rjs:PopCalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="TxtDoa" runat="server"
                                Font-Names="Tahoma" />
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <div class="sub-heading"> Family History:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>HTN:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtHtn" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>IHD:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtIhd" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>DM:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="TxtDm" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Asthma:</label></td>
                        <td>
                            <input type="text" id="TxtAsthma" runat="server" /></td>
                        <td class="right-align">
                            <label>Other:</label></td>
                        <td colspan="3">
                            <input type="text" id="TxtOther" runat="server" /></td>
                       
                    </tr>
                </table>
            </div>
            <div>                
                <div class="sub-heading"> Personal Medical & Surgical history:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtHistory" runat="server" /></td>
                    </tr>
                </table>
            </div>
            <div>                
                <div class="sub-heading">Chronic disease:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>HTN:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtHtn1" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>IHD:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtIhn1" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>DM:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="TxtDm1" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Asthma:</label></td>
                        <td>
                            <input type="text" id="TxtAsthma1" runat="server" /></td>
                        <td class="right-align">
                            <label>Other:</label></td>
                        <td colspan="3">
                            <input type="text" id="TxtOther1" runat="server" /></td>
                        
                    </tr>
                </table>
            </div>
            <div>                
                <div class="sub-heading">Personal Habits:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>Smoking:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtSmoking" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Substance abuse:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtAbuse" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Exercise:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="TxtExercise" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Stress:</label></td>
                        <td>
                            <input type="text" id="TxtStress" runat="server" /></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <div>                
                <div class="sub-heading">General Physcial Examination:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>Build:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtBuild" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Weight:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="TxtWeight" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Height:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="TxtHeight" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>BMI:</label></td>
                        <td>
                            <input type="text" id="TxtBmi" runat="server" /></td>
                        <td class="right-align">
                            <label>Waist:</label></td>
                        <td>
                            <input type="text" id="TxtWasit" runat="server" /></td>
                        <td class="right-align">
                            <label>Pulse:</label></td>
                        <td>
                            <input type="text" id="TxtPulse" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>BP(Diastolic):</label></td>
                        <td>
                            <input type="text" id="TxtBpDiastolic" runat="server" /></td>
                        <td class="right-align">
                            <label>BP(Systolic):</label></td>
                        <td>
                            <input type="text" id="TxtBpSystolic" runat="server" /></td>
                        <td class="right-align">
                            <label>Oral Cavity:</label></td>
                        <td>
                            <input type="text" id="TxtOral" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Thyroid:</label></td>
                        <td>
                            <input type="text" id="TxtThyroid" runat="server" /></td>
                        <td class="right-align">
                            <label>Skin:</label></td>
                        <td>
                            <input type="text" id="TxtSkin" runat="server" /></td>
                        <td class="right-align">
                            <label>Vision:</label></td>
                        <td>
                            <input type="text" id="TxtVision" runat="server" /></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <span style="float:left;width:15%"><label> Any specific deformity:</label></span>
                            <span style="float:left;width:85%">
                            <input type="text" id="TxtDefomity" runat="server" /></span>
                        </td>
                        
                    </tr>
                </table>
            </div>
            <div>
                
                <div class="sub-heading">Systemic Examination:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>GIT:</label></td>
                        <td class="right-align" style="width: 40%">
                            <input type="text" id="TxtGIT" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>CVS:</label></td>
                        <td class="right-align" style="width: 40%">
                            <input type="text" id="TxtCVS" runat="server" /></td>

                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Respiratory:</label></td>
                        <td>
                            <input type="text" id="txtRespiratory" runat="server" /></td>
                        <td class="right-align">
                            <label>CNS:</label></td>
                        <td>
                            <input type="text" id="txtCNS" runat="server" /></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <div>
                
                <div class="sub-heading">Laboratory Investigations:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>Hb%:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="txtHb" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>ERS:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="txtERS" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>TLC:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="txtTLC" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Platelets:</label></td>
                        <td>
                            <input type="text" id="txtPlatelets" runat="server" /></td>
                        <td class="right-align">
                            <label>FBS:</label></td>
                        <td>
                            <input type="text" id="txtFBS" runat="server" /></td>
                        <td class="right-align">
                            <label>Uric Acid:</label></td>
                        <td>
                            <input type="text" id="txtUricAcid" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Urine DR:</label></td>
                        <td>
                            <input type="text" id="txtUrineDR" runat="server" /></td>
                        <td class="right-align">
                            <label>TGD:</label></td>
                        <td>
                            <input type="text" id="txtTGD" runat="server" /></td>
                        <td class="right-align">
                            <label>HBs Ag:</label></td>
                        <td>
                            <input type="text" id="txtHBs" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Anti HCV:</label></td>
                        <td>
                            <input type="text" id="txtAntiHCV" runat="server" /></td>
                        <td class="right-align">
                            <label>S.Urea:</label></td>
                        <td>
                            <input type="text" id="txtUrea" runat="server" /></td>
                        <td class="right-align">
                            <label>S.Creatinine:</label></td>
                        <td>
                            <input type="text" id="txtCreatinine" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>S.Bilirubin:</label></td>
                        <td>
                            <input type="text" id="txtBilirubin" runat="server" /></td>
                        <td class="right-align">
                            <label>SGPT:</label></td>
                        <td>
                            <input type="text" id="txtSGPT" runat="server" /></td>
                        <td class="right-align">
                            <label>S.Cholesterol:</label></td>
                        <td>
                            <input type="text" id="txtCholesterol" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Blood Group:</label></td>
                        <td>
                            <input type="text" id="txtBloodGroup" runat="server" /></td>
                        
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <div>
                <div class="sub-heading">Miscellaneous:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>ECG:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="txtECG" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>CXR:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="txtCXR" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Adiometry:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="txtAdiometry" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Others:</label></td>
                        <td>
                            <input type="text" id="txtMOthers" runat="server" /></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <div>
                
                <div class="sub-heading">Vaccinations:</div>
                <table style="width: 100%;">
                    <tr>
                        <td class="right-align" style="width: 10%">
                            <label>History:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="txtVHistory" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Tetanus:</label></td>
                        <td class="right-align" style="width: 22%">
                            <input type="text" id="txtVTetanus" runat="server" /></td>
                        <td class="right-align" style="width: 10%">
                            <label>Typhoid:</label></td>
                        <td class="right-align" style="width: 23%">
                            <input type="text" id="txtVTyphoid" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="right-align">
                            <label>Others:</label></td>
                        <td>
                            <input type="text" id="txtVOthers" runat="server" /></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                        <td class="right-align">
                            <label></label>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <div>
                
                <div class="sub-heading">Current Medication:</div>
                <table style="width: 100%;">
                    <tr>

                        <td>
                            <input type="text" id="txtCurrentMedication" runat="server" /></td>

                    </tr>

                </table>
            </div>
            <div>
                
                <div class="sub-heading">Remarks / Advice:</div>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <input type="text" id="txtRemarks" runat="server" /></td>
                    </tr>

                </table>
            </div>
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" class="btn" value="Save" id="btn" onclick="saveHealthInfo()" />
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hdnHealthId" Value="0" runat="server" />

    <script src="HealthInfo.js"></script>
</asp:Content>

