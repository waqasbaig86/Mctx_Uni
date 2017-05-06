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
                            </span> </td>
                        <td style="white-space:nowrap" class="center empNo"><%# Eval("employee_number") %></td>
                        <td style="white-space:nowrap" class="center Name"><%# Eval("Name") %></td>
                        <td style="white-space:nowrap" class="fName"><%# Eval("fatherName") %></td> 
                        <td style="white-space:nowrap" class="Department"><%# Eval("departmentname") %></td>
                        <td style="white-space:nowrap;display:none" class="Departmentid"><%# Eval("departmentid") %></td>
                        <td style="white-space:nowrap" class="Designation"><%# Eval("designationname") %></td>
                        <td style="white-space:nowrap;display:none" class="Designationid"><%# Eval("designationid") %></td>
                        <td style="white-space:nowrap;" class="Shift"><%# Eval("shiftname") %></td>
                        <td style="white-space:nowrap;display:none" class="Shiftid"><%# Eval("shiftid") %></td>
                        <td style="white-space:nowrap;" class="email"><%# Eval("email") %></td>
                         <td style="white-space:nowrap;display:nones;" class="phone"><%# Eval("phoneno") %></td>
                        <td style="white-space:nowrap;display:nones;" class="cellno"><%# Eval("cellno") %></td> 
                        
                        <td style="white-space:nowrap ;display:none" class="status"><%# Eval("employeeStatus") %></td>
                        <td style="white-space:nowrap ;display:none" class="status"><%# Eval("employeeStatus") %></td>
                        <td style="white-space:nowrap ;display:none" class="status"><%# Eval("employeeStatus") %></td>
                        <td style="white-space:nowrap ;display:none" class="status"><%# Eval("employeeStatus") %></td>
                        <td style="white-space:nowrap;display:none" class="dob"><%# Eval("dob") %></td>
                        <td style="white-space:nowrap;display:nones;" class="Gender"><%# Eval("GenderName") %></td>
                        <td style="white-space:nowrap;display:none" class="Genderid"><%# Eval("GenderId") %></td> 
                        <td style="white-space:nowrap;display:none;" class="cnic"><%# Eval("Cnic") %></td>
                        <td style="white-space:nowrap;display:none;" class="address"><%# Eval("Adress") %></td>
                        
                        <%--<td style="white-space:nowrap" class="fullName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>--%>
                         <td style="white-space:nowrap;display:none;" class="city"><%# Eval("cityname") %></td>
                        <td style="white-space:nowrap;display:none" class="cityid"><%# Eval("cityid") %></td>                  
                        
                        
                        <td style="white-space:nowrap;display:none;" class="Religion"><%# Eval("religionname") %></td>
                        <td style="white-space:nowrap;display:none" class="religionid"><%# Eval("religionid") %></td>
                        <td style="white-space:nowrap;display:none;" class="Sectt"><%# Eval("secttname") %></td>
                        <td style="white-space:nowrap;display:none" class="Secttid"><%# Eval("secttid") %></td>
                        <td style="white-space:nowrap;display:none;" class="Cast"><%# Eval("castname") %></td>
                        <td style="white-space:nowrap;display:none" class="Castid"><%# Eval("castid") %></td>
                        <td style="white-space:nowrap;display:none;" class="Bloddgroup"><%# Eval("bloodgroupname") %></td>
                        <td style="white-space:nowrap;display:none" class="Bloddgroupid"><%# Eval("bloodgroupid") %></td>
                        <%--<td style="white-space:nowrap;display:none;" class="Education"><%# Eval("educationname") %></td>
                        <td style="white-space:nowrap;display:none" class="Educationid"><%# Eval("educationid") %></td>--%>
                        
                        
                        <td style="white-space:nowrap;display:none" class="EmployeeReportedid"><%# Eval("employee_reporting_id") %></td>
                        <td style="white-space:nowrap;display:none;" class="Employee"><%# Eval("Name") %></td>
                        
                        
                        <%--<td style="white-space:nowrap;display:none;" class="rank"><%# Eval("Rank_ID") %></td>
                        <td style="white-space:nowrap;display:none;" class="refAdd"><%# Eval("CurrAddr") %></td>
                        <td style="white-space:nowrap;display:none;" class="desgId"><%# Eval("Designation") %></td>
                        <td style="white-space:nowrap" class="status"><%# Eval("Status") %></td>
                        <td style="white-space:nowrap;display:none;" class="empID"><%# Eval("EID") %></td>--%>
                     <%--   <td style="white-space:nowrap;display:none;" class="phto33">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/VisitorPictures/"+Eval("photo")+".jpg" %>'/>
                        </td> --%>
                        <td class="phto">  <img  src='<%# "../EMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("id") + "&tableName=tbl_employee&ImagecolumnName=photo&PrimaryKeyColumnName=employee_id&date="+DateTime.Now+"") %>' height="50px" width="50px"/></td> 
                        <td><span  onclick="ShowDetails_Modal('<%# Eval("id") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndEmployee#
</asp:Content>

