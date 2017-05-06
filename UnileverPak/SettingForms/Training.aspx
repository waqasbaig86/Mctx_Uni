<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Training.aspx.cs" Inherits="SettingForms_Training" %>

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
                       <legend>Add/Modified Trainer</legend>
               
                        <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                        <tr>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblTrainerName" Text="Training Name:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtTrainingName" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                            <td colspan="1" style="width: 140px; text-align: left;">Training Category ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlTrainingCategoryid" runat="server"></asp:DropDownList>
                            </td>
                            </tr>
                            <tr>
                                 
                            <td style="width: 140px; text-align: left;">Training Prerequisite ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlprerequisteid" runat="server"></asp:DropDownList>
                            </td>
                                </tr>
                            <tr>
                                <td colspan="1" align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>
                                 <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveTraining();" runat="server" />
                        
                                <asp:Button ID="btnCleartrainer" Text="Clear" CssClass="btn" OnClientClick="return ClearTraining();" runat="server" />
                        
                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTraining();" runat="server" />
                            </td>
                            </tr>
                            
                        
                       <tr>
                           
                           </tr>
                           
                    </table>
                    </fieldset>
                </td>
            </tr>
    </table>
         <div id="divTrainingDetails"  >
                <fieldset id="fldTrainingDetails" >
                    <legend>Training Details</legend>
                     <div style="overflow: auto; width: 100%;">
                  
            
                    <table id="tblTrainingDetails" class="dataTable">
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
          getTraining();
        
        });
    
          function dataTable() {
              oTable = $("#tblTrainingDetails").dataTable();
          }
   
          function SaveTraining()
          {
             
              var i = 0;
              if ($("#tblTrainingDetails tr").length - 1 > 1) {
                  for (i = 0; i < $("#tblTrainingDetails tr").length - 1; i++) {

                      if ($("#txtTrainingNames" + i).html().toUpperCase().trim() == $("input[id$='txtTrainingName']").val().toUpperCase().trim()) {
                          alert("Training " + $("input[id$='txtTrainingName']").val() + " is alread added!");
                          $("input[id$='txtTrainingName']").val("");
                          return false;
                      }
                      
                  }
              }
              var Training_Name = $("input[id$='txtTrainingName']").val().trim();
              var Training_Category = $("select[id$='ddlTrainingCategoryid']").val().trim();
              var Training_Prerequisite = $("select[id$='ddlprerequisteid']").val().trim();
              var Training_PrerequisiteName = $("select[id$='ddlprerequisteid'] option:selected").text().trim();
              
         
              if (Training_Name == "")
                {
                    alert("Please Enter Training Name!");
                    return false;
            }
        
                    $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveTraining",
                    data: "{'Training_Name':'" + Training_Name + "','Training_Category':'" + Training_Category + "','Training_Prerequisite':'" + Training_Prerequisite + "','Training_PrerequisiteName':'" + Training_PrerequisiteName + "'}",
                    success:onsuccessSaveTraining,
                    error:onretrieveSaveTrainingError 
                    });
            return false; 
          }
          function onsuccessSaveTraining(msg)
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Saved!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txtTrainingName']").val("");
              $("select[id$='ddlTrainingCategoryid']").val("");
              $("select[id$='ddlprerequisteid']").val("");
              
              //getTraining();

              location.reload();
            return false;
          }
          function onretrieveSaveTrainingError(msg)
          {
          
            alert("Error In Saving Data!");
            return false; 
          }
          function ClearTraining()
          {
              $("input[id$='txtTrainingName']").val("");
              $("select[id$='ddlTrainingCategoryid']").val("");
              $("select[id$='ddlprerequisteid']").val("");
              
         
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
          }
          function getTraining()
          {
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getTraining",
                data: "{}", 
                success:onsuccessgetTraining,
                error:onretrievegetTraining 
            });
            return false; 
          }
          function onsuccessgetTraining(msg)
          {
              debugger;
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
                    tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Training ID</th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Training Name</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Training Category</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Training Category ID</th>";
                   tbl += "<th style='white-space:nowrap; text-align:left;'>Training Prerequisition </th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Training Prerequistion ID</th>";
                    //tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                    //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                    //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                    tbl += "</tr>";
                    tbl += "</thead>";
                    tbl += "<tbody>";
                    var traningName = "";
                    for (var i = 0; i < data.Training.length; i++) {
                        if (data.Training[i].prereqid == "0") {
                            traningName = "No Prerequisite";
                        }
                        else
                            traningName = data.Training[i].training_prereqiuisite_name;
                        tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                        tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteTrainingRecord(" + i + ");'> </td>";
                        tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                        tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.Training[i].trainingid + "</td>";
                            
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTrainingNames" + i + "'>" + data.Training[i].trainingname + "</td>";
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txttrainingcategory" + i + "'>" + data.Training[i].categoryname + "</td>";

                         tbl += "<td style='text-align:left; white-space:nowrap;display:none' id='txtcategoryid" + i + "'>" + data.Training[i].trainingcategoryid + "</td>";
                         tbl += "<td style='text-align:left; white-space:nowrap;' id='txtprereqname" + i + "'>" + traningName + "</td>";
                            
                         tbl += "<td style='text-align:left; white-space:nowrap;' id='txtpreid" + i + "'>" + data.Training[i].prereqid + "</td>";
                       // tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.Trainingl[i].created_date + " </td>";
                       // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.Training[i].modified_by + " </td>";
                       // tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.Training[i].modified_date + " </td>";
                          tbl += "</tr>";
                    }   
                    tbl += "</tbody>";
                    tbl += "</table>";
                    $("#tblTrainingDetails").html(tbl);
                    dataTable();
                    return false; 
          }

          function getRowID(rowID) {
              $("table[id$='tblTrainingDetails'] tr").css("background-color", "white");
              $("#trmain" + rowID).css("background-color", "#6798c1");

          }
          function onretrievegetTraining()
          {
            alert("Error In Loading Details!");
            return false;
          }

          function DeleteTrainingRecord(rowNo) {
          

              var Training_ID = $("#txtID" + rowNo).html();
          
                  if (confirm("Are you sure you wish to delete this Record?")) {
                      $.ajax({
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "Settingwebmethods.aspx/DeleteTraining",
                          data: "{'Training_ID':'" + Training_ID + "'}",
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
              getTraining();
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
             
             
              var Training_ID = $("#txtID" + rowNo).html().trim();
              $("input[id$='txtID']").val(Training_ID);

              var Training_Name = $("#txtTrainingNames" + rowNo).html().trim();
              $("input[id$='txtTrainingName']").val(Training_Name);
              var Training_category = $("#txtcategoryid" + rowNo).html().trim();
              $("select[id$='ddlTrainingCategoryid']").val(Training_category);
              var Training_prere = $("#txtpreid" + rowNo).html().trim();
              $("select[id$='ddlprerequisteid']").val(Training_prere);
              //var Trainer_Designation = $("#txtdesignation" + rowNo).html().trim();
              //$("input[id$='txtTrainerDesignation']").val(Trainer_Designation);
          
              $("input[id$='btnUpdate']").show();
              $("input[id$='btnSave']").attr("disabled", true);
              return false;
          }
          function UpdateTraining()
          {
              
              var Training_ID = $("input[id$='txtID']").val();

              var Training_Name = $("input[id$='txtTrainingName']").val();
              var Training_category = $("select[id$='ddlTrainingCategoryid']").val();
              var Trainer_prereq = $("select[id$='ddlprerequisteid']").val();
              //var Trainer_Designation = $("input[id$='txtTrainerDesignation']").val();
              var Training_PrerequisiteName = $("select[id$='ddlprerequisteid'] option:selected").text().trim();
              if (Training_Name == "")
                {
                    alert("Please Enter Training Name!");
                    return false;
            }
       
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/UpdateTraining",
                data: "{'Training_ID':'" + Training_ID + "','Training_Name':'" + Training_Name + "','Training_category':'" + Training_category + "','Trainer_prereq':'" + Trainer_prereq + "','Training_PrerequisiteName':'" + Training_PrerequisiteName + "'}",
                success:onsuccessUpdateTraining,
                error:onretrieveUpdateTraining 
            });
            return false; 
          }
          function onsuccessUpdateTraining()
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Updated!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txttrainingName']").val("");
              $("select[id$='ddlTrainingCategoryid']").val("");
              //$("input[id$='txtTrainerPhoneNo']").val("");
              //$("input[id$='txtTrainerDesignation']").val("");
              getTraining();

              ClearTraining();
              getTraining();
            return false;
          }
          function onretrieveUpdateTraining()
          {
            alert("Error In Updating Record!");
            return false;
          }
     
    
    
    
        </script>
</asp:Content>

