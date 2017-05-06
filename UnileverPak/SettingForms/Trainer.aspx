<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Trainer.aspx.cs" Inherits="SettingForms_Trainer" %>

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
                                <asp:Label ID="lblTrainerName" Text="Trainer Name:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtTrainerName" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lbltrainercompany" Text="Trainer Company:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtTrainerCompany" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                            </tr>
                            <tr>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblTrainerPhoneNo" Text="Trainer Phone No:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtTrainerPhoneNo" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblTrainerDesignation" Text="Trainer Designation:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtTrainerDesignation" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                            </tr>
                            <tr>
                            <td style="width: 140px; text-align: left;">Employee ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlemployeeid" runat="server"></asp:DropDownList>
                            </td>
                                </tr>
                            <tr>
                                <td colspan="1">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveTrainer();" runat="server" />
                        
                                <asp:Button ID="btnCleartrainer" Text="Clear" CssClass="btn" OnClientClick="return ClearTrainer();" runat="server" />
                        
                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTrainer();" runat="server" />
                            </td>
                                </tr>
                            <tr>
                            
                           </tr>
                            
                    </table>
                    </fieldset>
                </td>
            </tr>
    </table>
         <div id="divTrainerDetails"  >
                <fieldset id="fldTrainerDetails" >
                    <legend>Trainer Details</legend>
                     <div style="overflow: auto; width: 100%;">
                  
            
                    <table id="tblTrainerDetails" class="dataTable">
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
             getTrainer();
        
        });
    
          function dataTable() {
              oTable = $("#tblTrainerDetails").dataTable();
          }
   
          function SaveTrainer()
          {
              debugger;
              var i = 0;
              if ($("#tblTrainerDetails tr").length - 1 > 1) {
                  for (i = 0; i < $("#tblTrainerDetails tr").length - 1; i++) {

                      if ($("#txtTrainerName" + i).html().toUpperCase().trim() == $("input[id$='txtTrainerName']").val().toUpperCase().trim()) {
                          alert("Trainer " + $("input[id$='txtTrainerName']").val() + " is alread added!");
                          $("input[id$='txtTrainerName']").val("");
                          return false;
                      }
                       alert("test")
                  }
              }
              var Trainer_Name = $("input[id$='txtTrainerName']").val().trim();
              var Trainer_Company = $("input[id$='txtTrainerCompany']").val().trim();
              var Trainer_Phoneno = $("input[id$='txtTrainerPhoneNo']").val().trim();
              var Trainer_Designation = $("input[id$='txtTrainerDesignation']").val().trim();
              var employee = $("select[id$='ddlemployeeid']").val().trim();
              if (Trainer_Name == "")
                {
                    alert("Please Enter Trainer Name!");
                    return false;
            }
        
                    $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "SettingWebMethods.aspx/SaveTrainer",
                    data: "{'Trainer_Name':'" + Trainer_Name + "','Trainer_Company':'" + Trainer_Company + "','Trainer_Phoneno':'" + Trainer_Phoneno + "','Trainer_Designation':'" + Trainer_Designation + "','employee':'" + employee + "'}",
                    success:onsuccessSaveTrainer,
                    error:onretrieveSaveTrainerError 
                    });
            return false; 
          }
          function onsuccessSaveTrainer(msg)
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Saved!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txtTrainerName']").val("");
              $("input[id$='txtTrainerCompany']").val("");
              $("input[id$='txtTrainerPhoneNo']").val("");
              $("input[id$='txtTrainerDesignation']").val("");
              $("select[id$='ddlemployeeid']").val("");
             getTrainer();
            return false;
          }
          function onretrieveSaveTrainerError(msg)
          {
          
            alert("Error In Saving Data!");
            return false; 
          }
          function ClearTrainer()
          {
              $("input[id$='txtTrainerName']").val("");
              $("input[id$='txtTrainerCompany']").val("");
              $("input[id$='txtTrainerPhoneNo']").val("");
              $("input[id$='txtTrainerDesignation']").val("");
              $("select[id$='ddlemployeeid']").val("");
         
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
          }
          function getTrainer()
          {
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getTrainer",
                data: "{}", 
                success:onsuccessgetTrainer,
                error:onretrievegetTrainer 
            });
            return false; 
          }
          function onsuccessgetTrainer(msg)
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
                    tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Trainer ID</th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Trainer Name</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Trainer Company</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Trainer PhoneNo</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Trainer Designation</th>";
                    
                
                    tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Employee ID</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                    //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                   // tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                    tbl += "</tr>";
                    tbl += "</thead>";
                    tbl += "<tbody>";
                    for (var i = 0; i < data.TrainerDetail.length; i++) {
                        tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                        tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteTrainerRecord(" + i + ");'> </td>";
                        tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                        tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.TrainerDetail[i].trainerid + "</td>";
                            
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txttrainerName" + i + "'>" + data.TrainerDetail[i].trainername + "</td>";
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txttrainerCompany" + i + "'>" + data.TrainerDetail[i].trainercompany + "</td>";
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPhoneno" + i + "'>" + data.TrainerDetail[i].trainerphoneno + "</td>";
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtdesignation" + i + "'>" + data.TrainerDetail[i].trainerdesignation + "</td>";
                            
                                tbl += "<td style='text-align:left; white-space:nowrap;display:none' id='txtemployeeid" + i + "'>" + data.TrainerDetail[i].employeeid + "</td>";
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtemployeename" + i + "'>" + data.TrainerDetail[i].employeename + " </td>";
                               // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.TrainerDetail[i].modified_by + " </td>";
                               // tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.TrainerDetail[i].modified_date + " </td>";
                          tbl += "</tr>";
                    }   
                    tbl += "</tbody>";
                    tbl += "</table>";
                    $("#tblTrainerDetails").html(tbl);
                    dataTable();
                    return false; 
          }

          function getRowID(rowID) {
              $("table[id$='tblTrainerDetails'] tr").css("background-color", "white");
              $("#trmain" + rowID).css("background-color", "#6798c1");

          }
          function onretrievegetTrainer()
          {
            alert("Error In Loading Details!");
            return false;
          }

          function DeleteTrainerRecord(rowNo) {
          

              var Trainer_ID = $("#txtID" + rowNo).html();
          
                  if (confirm("Are you sure you wish to delete this Record?")) {
                      $.ajax({
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "Settingwebmethods.aspx/DeleteTrainer",
                          data: "{'Trainer_ID':'" + Trainer_ID + "'}",
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
              getTrainer();
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
             
             
              var Trainer_ID = $("#txtID" + rowNo).html().trim();
              $("input[id$='txtID']").val(Trainer_ID);

              var Trainer_Name = $("#txttrainerName" + rowNo).html().trim();
              $("input[id$='txtTrainerName']").val(Trainer_Name);
              var Trainer_company = $("#txttrainerCompany" + rowNo).html().trim();
              $("input[id$='txtTrainerCompany']").val(Trainer_company);
              var Trainer_phoneno = $("#txtPhoneno" + rowNo).html().trim();
              $("input[id$='txtTrainerPhoneNo']").val(Trainer_phoneno);
              var Trainer_Designation = $("#txtdesignation" + rowNo).html().trim();
              $("input[id$='txtTrainerDesignation']").val(Trainer_Designation);
              var Employee = $("#txtemployeeid" + rowNo).html().trim();
              $("select[id$='ddlemployeeid']").val(Employee);
          
              $("input[id$='btnUpdate']").show();
              $("input[id$='btnSave']").attr("disabled", true);
              return false;
          }
          function UpdateTrainer()
          {
              
              var Trainer_ID = $("input[id$='txtID']").val();

              var Trainer_Name = $("input[id$='txtTrainerName']").val();
              var Trainer_company = $("input[id$='txtTrainerCompany']").val();
              var Trainer_phoneno = $("input[id$='txtTrainerPhoneNo']").val();
              var Trainer_Designation = $("input[id$='txtTrainerDesignation']").val();
              var Employee = $("select[id$='ddlemployeeid']").val();
         
              if (Trainer_Name == "")
                {
                    alert("Please Enter Trainer Name!");
                    return false;
            }
       
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/updateTrainer",
                data: "{'Trainer_ID':'" + Trainer_ID + "','Trainer_Name':'" + Trainer_Name + "','Trainer_company':'" + Trainer_company + "','Trainer_phoneno':'" + Trainer_phoneno + "','Employee':'" + Employee + "'}",
                success:onsuccessUpdateTrainer,
                error:onretrieveUpdateTrainer 
            });
            return false; 
          }
          function onsuccessUpdateTrainer()
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Updated!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txtTrainerName']").val("");
              $("input[id$='txtTrainerCompany']").val("");
              $("input[id$='txtTrainerPhoneNo']").val("");
              $("input[id$='txtTrainerDesignation']").val("");
              $("select[id$='ddlemployeeid']").val("");
              getTrainer();

              ClearTrainer()
              getTrainer();
            return false;
          }
          function onretrieveUpdateTrainer()
          {
            alert("Error In Updating Record!");
            return false;
          }
     
    
    
    
        </script>
</asp:Content>

