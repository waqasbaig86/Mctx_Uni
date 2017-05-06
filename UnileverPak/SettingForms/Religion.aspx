<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Religion.aspx.cs" Inherits="SettingForms_Religion" %>

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
                   <legend>Add/Modified Religion</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblRankName" Text="Religion:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtReligionName" Width="95%"  class="alpha" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                            <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveReligion();" runat="server" />
                        
                            <asp:Button ID="btnClearReligion" Text="Clear" CssClass="btn" OnClientClick="return ClearReligion();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" CssClass="btn" Style="display: none;" OnClientClick="return UpdateReligion();" runat="server" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
    
    <div id="test">
    </div>
      <asp:Button ID="Button1" Text="Export To PDF" CssClass="btn"  OnClientClick="return ExportToPDF();" style="display:none;" runat="server" />
     <div id="divReligionDetails"  >
            <fieldset id="fldReligionDetails" >
                <legend>Religions Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                <table id="tblReligionDetails" class="dataTable">
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
             //alert("tdddd");

             setTimeout(function () {
                 getReligion();
             }, 500)

       
        
         });

         $(document).raady(function () {

             alert("pakistan");
         })
    
      function dataTable() {
          oTable = $("#tblReligionDetails").dataTable();
      }
   
      function SaveReligion()
      {
          var i = 0;
          if ($("#tblReligionDetails tr").length - 1 > 1) {
              for (i = 0; i < $("#tblReligionDetails tr").length - 1; i++) {

                  if ($("#txtReligionName" + i).html().toUpperCase().trim() == $("input[id$='txtReligionName']").val().toUpperCase().trim()) {
                      alert("Religion is" + $("input[id$='txtReligionName']").val() + " already added!");
                      $("input[id$='txtReligionName']").val("");
                      return false;
                  }
                  // alert("test")
              }
          }
          var Religion_Name = $("input[id$='txtReligionName']").val().trim();
         
          if (Religion_Name == "")
            {
                alert("Please Enter Religion Name!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveReligions",
                data: "{'Religion_Name':'" + Religion_Name + "'}",
                success:onsuccessSaveReligion,
                error:onretrieveSaveReligionError 
                });
        return false; 
      }
      function onsuccessSaveReligion(msg)
      {
         showSuccessMsg("Record Successfully Saved!");
        $("input[id$='txtReligionName']").val("");
        getReligion();
        return false;
      }
      function onretrieveSaveReligionError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearReligion()
      {
        $("input[id$='txtReligionName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getReligion()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getReligionDetail",
            data: "{}", 
            success:onsuccessgetReligion,
            error:onretrievegetReligion 
        });
        return false; 
      }
      function onsuccessgetReligion(msg)
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Religion ID</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Religion Name</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ReligionDetail.length; i++) {                   
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteReligionRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.ReligionDetail[i].religion_id + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtReligionName" + i + "'>" + data.ReligionDetail[i].religion_name + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ReligionDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ReligionDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ReligionDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ReligionDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblReligionDetails").html(tbl);
                dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='tblReligionDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetReligion()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteReligionRecord(rowNo) {
          

          var Religion_ID = $("#txtID" + rowNo).html();
          
              if (confirm("Are you sure you wish to delete this Record?")) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "Settingwebmethods.aspx/DeleteReligion",
                      data: "{'Religion_ID':'" + Religion_ID + "'}",
                      success: onsuccessDeleteData,
                      error: OnretrievePhysicianError
                  });
              
              return false;
          }
          else
                  return false;

      }

      function onsuccessDeleteData(msg) {


          showSuccessMsg("Record Successfully Deleted!");
        
          getReligion();
          return false;

      }

      function OnretrievePhysicianError(msg) {
         // getReligionalRecod();
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

          var DEPT_NAME = $("#txtReligionName"+rowNo).html().trim();
          $("input[id$='txtReligionName']").val(DEPT_NAME);
          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateReligion()
      {
          var Religion_ID = $("input[id$='txtID']").val();

          var Religion_Name = $("input[id$='txtReligionName']").val();
         
          if (Religion_Name == "")
            {
                alert("Please Enter Religion Name!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/UpdateReligions",
            data: "{'Religion_ID':'" + Religion_ID + "','Religion_Name':'" + Religion_Name + "'}",
            success:onsuccessUpdateReligion,
            error:onretrieveUpdateReligion 
        });
        return false; 
      }
      function onsuccessUpdateReligion()
      {
         
          showSuccessMsg("Record Updated successfully!");
          $("input[id$='txtReligionName']").val("");
          getReligion();

        ClearReligion();
      
        return false;
      }
      function onretrieveUpdateReligion()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
      var doc = new jsPDF();
      var specialElementHandlers = {
          '#content': function (element, renderer) {
              return true;
          }
      };

      function ExportToPDF() {
         
          doc.fromHTML($('#tblReligionDetails tr:last').text(), 15, 15, {
              'width': 170,
              'elementHandlers': specialElementHandlers
          });
          doc.save('relation.pdf');

      }
    
    
    </script>
</asp:Content>

