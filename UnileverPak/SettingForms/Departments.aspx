<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Departments.aspx.cs" Inherits="SettingForms_Departments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="container">
         <table style="width:100%;margin-top:0%;vertical-align:top;">
        <tr>
                <td>
                    <div class="sussessMessageDiv" id="divSuccessMsg" style="display: none">&nbsp;
                    </div>
                     <div class="ErrorMessageDiv" id="ErrorMessageDiv" style="display: none">&nbsp;
                    </div>
                </td>
            </tr>
        <tr>
            <td>
               <fieldset>
                   <legend>Add/Modified Department</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblDepartmentName" Text="Department Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtDepartmentName" Width="95%"   class="alphanumeric" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                            <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveDepartment();" runat="server" />
                        
                            <asp:Button ID="btnClearDepartment" Text="Clear" CssClass="btn" OnClientClick="return ClearDepartment();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateDepartment();" runat="server" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divGetDepartmentDetails"  >
            <fieldset id="fldGetDepartmentDetails" >
                <legend>Departments Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblGetDepartmentDetails" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>
     <script type="text/javascript" language="javascript">
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
        getDepartment();
        
    });
    
      function dataTable() {
          oTable = $("#tblGetDepartmentDetails").dataTable();
      }
   
      function SaveDepartment()
      {
          var i = 0;
          if ($("#tblGetDepartmentDetails tr").length - 1 > 1) {
              for (i = 0; i < $("#tblGetDepartmentDetails tr").length - 1; i++) {

                  if ($("#txtDepartmentName" + i).html().toUpperCase().trim() == $("input[id$='txtDepartmentName']").val().toUpperCase().trim()) {
                      alert("Department is " + $("input[id$='txtDepartmentName']").val() + " already added!");
                      $("input[id$='txtDepartmentName']").val("");
                      return false;
                  }
                  // alert("test")
              }
          }
          var Department_Name = $("input[id$='txtDepartmentName']").val().trim();
         
          if (Department_Name == "")
            {
                alert("Please Enter Department Name!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "SettingWebMethods.aspx/SaveDepartment",
                data: "{'Department_Name':'" + Department_Name + "'}",
                success:onsuccessSaveDepartment,
                error:onretrieveSaveDepartmentError 
                });
        return false; 
      }
      function onsuccessSaveDepartment(msg)
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Saved!");
          $("#divSuccessMsg").fadeOut(6000);
        $("input[id$='txtDepartmentName']").val("");
       getDepartment();
        return false;
      }
      function onretrieveSaveDepartmentError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearDepartment()
      {
        $("input[id$='txtDepartmentName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getDepartment()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "SettingWebMethods.aspx/getDepartmentDetail",
            data: "{}", 
            success:onsuccessgetDepartment,
            error:onretrievegetDepartment 
        });
        return false; 
      }
      function onsuccessgetDepartment(msg)
      {
          
        var data = msg.d;
        if(oTable !=null)
                    {
                      oTable.fnClearTable();
                      oTable.fnDestroy();
                    }  
          var tbl = "";
                tbl += "<thead>";
                tbl += "<tr>";
                tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
                tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Department ID</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Department Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Factory Id</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.GetDepartmentDetail.length; i++) {                   
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteDepartmentRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.GetDepartmentDetail[i].department_id + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDepartmentName" + i + "'>" + data.GetDepartmentDetail[i].department_name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtfactoryid" + i + "'>" + data.GetDepartmentDetail[i].factory_id + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.GetDepartmentDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.GetDepartmentDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.GetDepartmentDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.GetDepartmentDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblGetDepartmentDetails").html(tbl);
                dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='tblGetDepartmentDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetDepartment()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteDepartmentRecord(rowNo) {
          

          var Department_ID = $("#txtID" + rowNo).html();
          
              if (confirm("Are you sure you wish to delete this Record?")) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "SettingWebMethods.aspx/DeleteDepartment",
                      data: "{'Department_ID':'" + Department_ID + "'}",
                      success: onsuccessDeleteData,
                      error: OnretrievePhysicianError
                  });
              
              return false;
          }
          else
                  return false;

      }

      function onsuccessDeleteData(msg) {
          
                  
          showSuccessMsg("Record Deleted successfully!");
          getDepartment();
          return false;

      }

      function OnretrievePhysicianError(msg) {
         // getDepartmentalRecod();
          alert(msg.responseText);
          $("#ErrorMessageDiv").show();
          $("#ErrorMessageDiv").html("");
          $("#ErrorMessageDiv").html("Error in Record Deleting!" );
          $("#ErrorMessageDiv").fadeOut(6000);
          return false;
      }

      function EditRecord(rowNo)
      {
          var ID = $("#txtID"+rowNo).html().trim();
          $("input[id$='txtID']").val(ID);

          var Department_ID = $("#txtDepartmentName" + rowNo).html().trim();
          $("input[id$='txtDepartmentName']").val(Department_ID);
          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateDepartment()
      {
          var Department_ID = $("input[id$='txtID']").val();

          var Department_Name = $("input[id$='txtDepartmentName']").val();
         
          if (Department_Name == "")
            {
                alert("Please Enter Department Name!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "SettingWebMethods.aspx/UpdateDepartment",
            data: "{'Department_ID':'" + Department_ID + "','Department_Name':'" + Department_Name + "'}",
            success:onsuccessUpdateDepartments,
            error:onretrieveUpdateDepartments 
        });
        return false; 
      }
      function onsuccessUpdateDepartments()
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Updated!");
          $("#divSuccessMsg").fadeOut(6000);
          $("input[id$='txtDepartmentName']").val("");
          getDepartment();

        ClearDepartment();
        getDepartment();
        return false;
      }
      function onretrieveUpdateDepartments()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>

