<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="EmployeeHandler.aspx.cs" Inherits="EMS_CallBack_EmployeeHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    #StartEmployee#
            <asp:Repeater ID="rptEmployee" runat="server">
                <ItemTemplate>
                    <tr>
                     
                        <td>
                           
                            <span class="edit-icon" onclick="editEmployees('<%# Eval("id") %>',this)">
                            <img src='../images/Edit.png'/>
                    </span>
                             <span class="edit-icon" onclick="addMedicalDetail('<%# Eval("id") %>',this)">
                            <img src='../images/Edit.png'/>
                    </span> 
                           </td>
                        <td style="white-space:nowrap" class="center empNo"><%# Eval("employee_number") %></td>
                        <td style="white-space:nowrap" class="center Name"><%# Eval("Name") %></td>                        
                        <td style="white-space:nowrap" class="Department"><%# Eval("departmentname") %></td>                        
                        <td style="white-space:nowrap" class="Designation"><%# Eval("designationname") %></td>                        
                        <td style="white-space:nowrap;" class="Shift"><%# Eval("shiftname") %></td>                        
                        <td style="white-space:nowrap;" class="email"><%# Eval("email") %></td>
                        <td style="white-space:nowrap;" class="phone"><%# Eval("phoneno") %></td>
                        <td style="white-space:nowrap;" class="cellno"><%# Eval("cellno") %></td>                         
                        <td style="white-space:nowrap;" class="dob"><%# Eval("dob") %></td>
                        <td style="white-space:nowrap;" class="Gender"><%# Eval("GenderName") %></td>
                        <td class="phto">  <img  src='<%# "../EMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("id") + "&tableName=tbl_employee&ImagecolumnName=photo&PrimaryKeyColumnName=employee_id&date="+DateTime.Now+"") %>' style="height:50px; width:50px"/></td> 

                        
                        <td style="white-space:nowrap;display:none">
                            <span class="Shiftid"><%# Eval("shiftid") %></span>
                            <span class="Departmentid"><%# Eval("departmentid") %></span>
                            <span class="fName"><%# Eval("fatherName") %></span>
                            <span class="status"><%# Eval("employeeStatus") %></span>
                            <span class="GenderId"><%# Eval("GenderId") %></span>
                            <span class="cnic"><%# Eval("Cnic") %></span>
                            <span class="address"><%# Eval("Adress") %></span>
                            <span class="cityid"><%# Eval("cityid") %></span>
                            <span class="Designationid"><%# Eval("designationid") %></span>

                            <span class="religionid"><%# Eval("religionid") %></span>
                            <span class="Secttid"><%# Eval("secttid") %></span>
                            <span class="Castid"><%# Eval("castid") %></span>
                            <span class="Bloddgroupid"><%# Eval("bloodgroupid") %></span>
                            <span class="EmployeeReportedid"><%# Eval("employee_reporting_id") %></span>

                            <span class="education_id"><%# Eval("education_id") %></span>
                            <span class="Employer_Id"><%# Eval("Employer_Id") %></span>

                            <span class="Account_No"><%# Eval("Account_No") %></span>
                            <span class="Eobi_No"><%# Eval("Eobi_No") %></span>
                            <span class="Ntn_no"><%# Eval("Ntn_no") %></span>
                            <span class="Select_Bank"><%# Eval("Select_Bank") %></span>
                            <span class="Finance_info_id"><%# Eval("Finance_info_id") %></span>
                        </td>                                                                                                                                                                                                
                     <%--   <td style="white-space:nowrap;display:none;" class="phto33">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/VisitorPictures/"+Eval("photo")+".jpg" %>'/>
                        </td> --%>
                        
                        <td><span  onclick="ShowDetails_Modal('<%# Eval("id") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndEmployee#
</asp:Content>

