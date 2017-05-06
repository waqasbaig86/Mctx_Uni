<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Sectt.aspx.cs" Inherits="SettingForms_Sectt" %>

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
                       <legend>Add/Modified Sect</legend>
               
                        <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                        <tr>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblSecttName" Text="Sectt Name:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtSecttName" Width="95%"   class="alpha" runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                        
                       
                            <td  align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>
                        
                   
                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveSectt();" runat="server" />
                        
                                <asp:Button ID="btnClearSectt" Text="Clear" CssClass="btn" OnClientClick="return ClearSectt();" runat="server" />
                        
                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateSectt();" runat="server" />
                            </td>
                        </tr>
                    </table>
                    </fieldset>
                </td>
            </tr>

        </table>
         <div id="divSecttDetails"  >
                <fieldset id="fldSecttDetails" >
                    <legend>Sect Details</legend>
                     <div style="overflow: auto; width: 100%;">
                  
            
                    <table id="tblSecttDetails" class="dataTable">
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
            getSectt();
        
        });
    
          function dataTable() {
              oTable = $("#tblSecttDetails").dataTable();
          }
   
          function SaveSectt()
          {
              var i = 0;
              if ($("#tblSecttDetails tr").length - 1 > 1) {
                  for (i = 0; i < $("#tblSecttDetails tr").length - 1; i++) {

                      if ($("#txtSecttName" + i).html().toUpperCase().trim() == $("input[id$='txtSecttName']").val().toUpperCase().trim()) {
                          alert("Sectt " + $("input[id$='txtSecttName']").val() + " is alread added!");
                          $("input[id$='txtSecttName']").val("");
                          return false;
                      }
                      // alert("test")
                  }
              }
              var Sectt_Name = $("input[id$='txtSecttName']").val().trim();
         
              if (Sectt_Name == "")
                {
                    alert("Please Enter Sectt Name!");
                    return false;
            }
        
                    $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveSectt",
                    data: "{'Sectt_Name':'" + Sectt_Name + "'}",
                    success:onsuccessSaveSectt,
                    error:onretrieveSaveSecttError 
                    });
            return false; 
          }
          function onsuccessSaveSectt(msg)
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Saved!");
              $("#divSuccessMsg").fadeOut(6000);
            $("input[id$='txtSecttName']").val("");
            getSectt();
            return false;
          }
          function onretrieveSaveSecttError(msg)
          {
          
            alert("Error In Saving Data!");
            return false; 
          }
          function ClearSectt()
          {
            $("input[id$='txtSecttName']").val("");
         
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
          }
          function getSectt()
          {
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getSecttDetail",
                data: "{}", 
                success:onsuccessgetSectt,
                error:onretrievegetSectt 
            });
            return false; 
          }
          function onsuccessgetSectt(msg)
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
                    tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Sectt ID</th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Sect Name</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Religion ID</th>";
                
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                    tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                    tbl += "</tr>";
                    tbl += "</thead>";
                    tbl += "<tbody>";
                    for (var i = 0; i < data.SecttDetail.length; i++) {                   
                        tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                        tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteSecttRecord(" + i + ");'> </td>";
                                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.SecttDetail[i].sectt_id + "</td>";
                            
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtSecttName" + i + "'>" + data.SecttDetail[i].sectt_name + "</td>";
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtSecttName" + i + "'>" + data.SecttDetail[i].religion_id + "</td>";
                            
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.SecttDetail[i].created_by + "</td>";
                                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.SecttDetail[i].created_date + " </td>";
                                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.SecttDetail[i].modified_by + " </td>";
                                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.SecttDetail[i].modified_date + " </td>";
                          tbl += "</tr>";
                    }   
                    tbl += "</tbody>";
                    tbl += "</table>";
                    $("#tblSecttDetails").html(tbl);
                    dataTable();
                    return false; 
          }

          function getRowID(rowID) {
              $("table[id$='tblSecttDetails'] tr").css("background-color", "white");
              $("#trmain" + rowID).css("background-color", "#6798c1");

          }
          function onretrievegetSectt()
          {
            alert("Error In Loading Details!");
            return false;
          }

          function DeleteSecttRecord(rowNo) {
          

              var Sectt_ID = $("#txtID" + rowNo).html();
          
                  if (confirm("Are you sure you wish to delete this Record?")) {
                      $.ajax({
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "Settingwebmethods.aspx/DeleteSectt",
                          data: "{'Sectt_ID':'" + Sectt_ID + "'}",
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
              getSectt();
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

              var Sectt_ID = $("#txtSecttName" + rowNo).html().trim();
              $("input[id$='txtSecttName']").val(Sectt_ID);
          
              $("input[id$='btnUpdate']").show();
              $("input[id$='btnSave']").attr("disabled", true);
              return false;
          }
          function UpdateSectt()
          {
              var Sectt_ID = $("input[id$='txtID']").val();

              var Sectt_Name = $("input[id$='txtSecttName']").val();
         
              if (Sectt_Name == "")
                {
                    alert("Please Enter Sectt Name!");
                    return false;
            }
       
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/UpdateSectt",
                data: "{'Sectt_ID':'" + Sectt_ID + "','Sectt_Name':'" + Sectt_Name + "'}",
                success:onsuccessUpdateSectts,
                error:onretrieveUpdateSectts 
            });
            return false; 
          }
          function onsuccessUpdateSectts()
          {
              $("#divSuccessMsg").show();
              $("#divSuccessMsg").html("");
              $("#divSuccessMsg").html("Record Successfully Updated!");
              $("#divSuccessMsg").fadeOut(6000);
              $("input[id$='txtSecttName']").val("");
              getSectt();

            ClearSectt();
            //getSecttt();
            return false;
          }
          function onretrieveUpdateSectts()
          {
            alert("Error In Updating Record!");
            return false;
          }
     
    
    
    
        </script>
</asp:Content>

