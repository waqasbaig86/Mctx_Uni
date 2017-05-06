<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Education.aspx.cs" Inherits="SettingForms_Education" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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
                   <legend>Add/Modified Education</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblEducationName" Text="Education Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtEducationName" Width="95%"   class="alpha" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                            <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveEducation();" runat="server" />
                        
                            <asp:Button ID="btnClearEducation" Text="Clear" CssClass="btn" OnClientClick="return ClearEducation();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateEducation();" runat="server" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divEducationDetails" >
            <fieldset id="fldEducationDetails" >
                <legend>Education Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                <table id="tblEducationDetails" class="dataTable">
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
        getEducation();
        
    });
    
      function dataTable() {
          oTable = $("#tblEducationDetails").dataTable();
      }
   
      function SaveEducation()
      {
          var i = 0;
          if ($("#tblEducationDetails tr").length - 1 > 1) {
              for (i = 0; i < $("#tblEducationDetails tr").length - 1; i++) {

                  if ($("#txtEducationName" + i).html().toUpperCase().trim() == $("input[id$='txtEducationName']").val().toUpperCase().trim()) {
                      alert("Education " + $("input[id$='txtEducationName']").val() + " is already added!");
                      $("input[id$='txtEducationName']").val("");
                      return false;
                  }
                  // alert("test")
              }
          }
          var Education_Name = $("input[id$='txtEducationName']").val().trim();
         
          if (Education_Name == "")
            {
                alert("Please Enter Education Name!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveEducation",
                data: "{'Education_Name':'" + Education_Name + "'}",
                success:onsuccessSaveEducation,
                error:onretrieveSaveEducationError 
                });
        return false; 
      }
      function onsuccessSaveEducation(msg)
      {
          showSuccessMsg("Record Saved successfully!");
        $("input[id$='txtEducationName']").val("");
        getEducation();
        return false;
      }
      function onretrieveSaveEducationError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearEducation()
      {
        $("input[id$='txtEducationName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getEducation()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getEducationDetail",
            data: "{}", 
            success:onsuccessgetEducation,
            error:onretrievegetEducation 
        });
        return false; 
      }
      function onsuccessgetEducation(msg)
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Education ID</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Education Name</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.EducationDetail.length; i++) {                   
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteEducationRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EducationDetail[i].education_id + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEducationName" + i + "'>" + data.EducationDetail[i].education_name + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EducationDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EducationDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EducationDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EducationDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblEducationDetails").html(tbl);
                dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='tblEducationDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetEducation()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteEducationRecord(rowNo) {
          

          var Education_ID = $("#txtID" + rowNo).html();
          
              if (confirm("Are you sure you wish to delete this Record?")) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "Settingwebmethods.aspx/DeleteEducation",
                      data: "{'Education_ID':'" + Education_ID + "'}",
                      success: onsuccessDeleteData,
                      error: OnretrievePhysicianError
                  });
              
              return false;
          }
          else
                  return false;

      }

      function onsuccessDeleteData(msg) {

          showSuccessMsg("Record deleted successfully!");
          getEducation();
          return false;

      }

      function OnretrievePhysicianError(msg) {
         // getEducationalRecod();
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

          var Education_ID = $("#txtEducationName" + rowNo).html().trim();
          $("input[id$='txtEducationName']").val(Education_ID);
          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateEducation()
      {
          var Education_ID = $("input[id$='txtID']").val();

          var Education_Name = $("input[id$='txtEducationName']").val();
         
          if (Education_Name == "")
            {
                alert("Please Enter Education Name!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/UpdateEducation",
            data: "{'Education_ID':'" + Education_ID + "','Education_Name':'" + Education_Name + "'}",
            success:onsuccessUpdateEducation,
            error:onretrieveUpdateEducation 
        });
        return false; 
      }
      function onsuccessUpdateEducation()
      {
        
          showSuccessMsg("Record Updated successfully!");
          $("input[id$='txtEducationName']").val("");
          getEducation();

        ClearEducation();
        getEducation();
        return false;
      }
      function onretrieveUpdateEducation()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>

