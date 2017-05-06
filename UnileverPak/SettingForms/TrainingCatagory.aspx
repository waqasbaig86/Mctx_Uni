<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="TrainingCatagory.aspx.cs" Inherits="SettingForms_TrainingCatagory" %>

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
                       <legend>Add/Modified Training Catagory</legend>
               
                        <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                        <tr>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblTrainingCategoryName" Text="Training Category Name:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtTrainingCategoryName" Width="95%"   class="alpha" runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                        
                       
                            <td  align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>
                        
                   
                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveTrainingCategory();" runat="server" />
                        
                                <asp:Button ID="btnClearTrainingCategory" Text="Clear" CssClass="btn" OnClientClick="return ClearTrainingCategory();" runat="server" />
                        
                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTrainingCategory();" runat="server" />
                            </td>
                        </tr>
                    </table>
                    </fieldset>
                </td>
            </tr>

        </table>
         <div id="divTrainingCategoryDetails"  >
                <fieldset id="fldTrainingCategoryDetails" >
                    <legend>Training Category Details</legend>
                     <div style="overflow: auto; width: 100%;">
                  
            
                    <table id="tblTrainingCategoryDetails" class="dataTable">
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
            getTrainingCategory();
        
        });
    
          function dataTable() {
              oTable = $("#tblTrainingCategoryDetails").dataTable();
          }
   
          function SaveTrainingCategory()
          {
              var i = 0;
              if ($("#tblTrainingCategoryDetails tr").length - 1 > 1) {
                  for (i = 0; i < $("#tblTrainingCategoryDetails tr").length - 1; i++) {

                      if ($("#txtTrainingCategoryName" + i).html().toUpperCase().trim() == $("input[id$='txtTrainingCategoryName']").val().toUpperCase().trim()) {
                          alert("Training Category " + $("input[id$='txtTrainingCategoryName']").val() + " is alread added!");
                          $("input[id$='txtTrainingCategoryName']").val("");
                          return false;
                      }
                      // alert("test")
                  }
              }
              var Training_category = $("input[id$='txtTrainingCategoryName']").val().trim();
         
              if (Training_category == "")
                {
                    alert("Please Enter Training Category Name!");
                    return false;
            }
        
                    $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveTrainingcategory",
                    data: "{'Training_category':'" + Training_category + "'}",
                    success:onsuccessSaveTrainingCategory,
                    error:onretrieveSaveTrainingCategoryError 
                    });
            return false; 
          }
          function onsuccessSaveTrainingCategory(msg)
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Saved!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txtTrainingCategoryName']").val("");
              getTrainingCategory();
            return false;
          }
          function onretrieveSaveTrainingCategoryError(msg)
          {
          
            alert("Error In Saving Data!");
            return false; 
          }
          function ClearTrainingCategory()
          {
              $("input[id$='txtTrainingCategoryName']").val("");
         
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
          }
          function getTrainingCategory()
          {
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getTrainingCategory",
                data: "{}", 
                success:onsuccessgetTrainingcategory,
                error:onretrievegetTrainingcategory 
            });
            return false; 
          }
          function onsuccessgetTrainingcategory(msg)
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
                    tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Training Category ID</th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Training Category Name</th>";
                   // tbl += "<th style='white-space:nowrap; text-align:left;'>Religion ID</th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                    tbl += "</tr>";
                    tbl += "</thead>";
                    tbl += "<tbody>";
                    for (var i = 0; i < data.TrainingCategory.length; i++) {
                        tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                        tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteSecttRecord(" + i + ");'> </td>";
                                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.TrainingCategory[i].training_category_id + "</td>";
                            
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txttrainingName" + i + "'>" + data.TrainingCategory[i].training_category_name + "</td>";
                               // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtSecttName" + i + "'>" + data.TrainingCategory[i].religion_id + "</td>";
                            
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.TrainingCategory[i].created_by + "</td>";
                                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.TrainingCategory[i].created_date + " </td>";
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.TrainingCategory[i].modified_by + " </td>";
                                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.TrainingCategory[i].modified_date + " </td>";
                          tbl += "</tr>";
                    }   
                    tbl += "</tbody>";
                    tbl += "</table>";
                    $("#tblTrainingCategoryDetails").html(tbl);
                    dataTable();
                    return false; 
          }

          function getRowID(rowID) {
              $("table[id$='tblTrainingCategoryDetails'] tr").css("background-color", "white");
              $("#trmain" + rowID).css("background-color", "#6798c1");

          }
          function onretrievegetTrainingcategory()
          {
            alert("Error In Loading Details!");
            return false;
          }

          function DeleteSecttRecord(rowNo) {
          

              var Training_Category = $("#txtID" + rowNo).html();
          
                  if (confirm("Are you sure you wish to delete this Record?")) {
                      $.ajax({
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "Settingwebmethods.aspx/DeleteTrainingCategory",
                          data: "{'Training_Category':'" + Training_Category + "'}",
                          success: onsuccessDeleteData,
                          error: OnretrievePhysicianError
                      });
              
                  return false;
              }
              else
                      return false;

          }

          function onsuccessDeleteData(msg) {



              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Deleted!");
              $("#divSuccessMsg").fadeOut(6000);
              getTrainingCategory();
              return false;

          }

          function OnretrievePhysicianError(msg) {
             // getSecttalRecod();
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

              var Training_category = $("#txttrainingName" + rowNo).html().trim();
              $("input[id$='txtTrainingCategoryName']").val(Training_category);
          
              $("input[id$='btnUpdate']").show();
              $("input[id$='btnSave']").attr("disabled", true);
              return false;
          }
          function UpdateTrainingCategory()
          {
              var ID = $("input[id$='txtID']").val();

              var Training_category = $("input[id$='txtTrainingCategoryName']").val();
         
              if (Training_category == "")
                {
                    alert("Please Enter Sectt Name!");
                    return false;
            }
       
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/UpdateTrainingCategory",
                data: "{'ID':'" + ID + "','Training_category':'" + Training_category + "'}",
                success:onsuccessUpdateTrainingCategory,
                error:onretrieveUpdateTrainingCategory 
            });
            return false; 
          }
          function onsuccessUpdateTrainingCategory()
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Updated!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txtTrainingCategoryName']").val("");
              getTrainingCategory();

              ClearTrainingCategory();
           getTrainingCategory();
            return false;
          }
          function onretrieveUpdateTrainingCategory()
          {
            alert("Error In Updating Record!");
            return false;
          }
     
    
    
    
        </script>
</asp:Content>

