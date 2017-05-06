<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Relation.aspx.cs" Inherits="SettingForms_Relation" %>

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
                    <legend>Add/Modified Relation</legend>

                    <table style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">
                                <asp:Label ID="lblRelationName" Text="Relation:" runat="server"></asp:Label>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtRelationName" Width="95%" Class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveRelation();" runat="server" />

                                <asp:Button ID="btnClearRank" Text="Clear" CssClass="btn" OnClientClick="return ClearRank();" runat="server" />

                                <asp:Button ID="btnUpdate" CssClass="btn" Text="Update" Style="display: none;"
                                    Width="75px" OnClientClick="return UpdateRank();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divRelationDetails"  >
            <fieldset id="fldRelationDetails"  >
                <legend>Relation Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
           
                <table id="tblRelationDetails"  class="dataTable">
                </table>
                     </div>
	</fieldset>
        </div>

     <script type="text/javascript">
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
          
        getRelation();
        
    });
    
      function dataTable() {
          oTable = $("#tblRelationDetails").dataTable();
      }
   
      function SaveRelation()
      {
         
          var i=0;
          var Relation_Name = $("input[id$='txtRelationName']").val().trim();
          //alert($("#tblRelationDetails tr").length - 1);
          if ($("#tblRelationDetails tr").length - 1>1){
          for (i = 0; i < $("#tblRelationDetails tr").length - 1; i++)
          {
              
              if ($("#txtRelationName" + i).html().toUpperCase().trim() == $("input[id$='txtRelationName']").val().toUpperCase().trim()) {
                  alert("Relationship " + $("input[id$='txtRelationName']").val() + " is alread added!");
                  $("input[id$='txtRelationName']").val("");
                  return false;
              }
                 // alert("test")
             
             }
          }
          if (Relation_Name == "")
            {
                alert("Please Enter Relation!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveRelation",
                data: "{'Relation_Name':'" + Relation_Name + "'}",
                success:onsuccessSaveRelation,
                error:onretrieveSaveRelationError 
                });
        return false; 
      }
      function onsuccessSaveRelation(msg)
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Saved!");
          $("#divSuccessMsg").fadeOut(6000);
        $("input[id$='txtRelationName']").val("");
        getRelation();
        return false;
      }
      function onretrieveSaveRelationError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearRank()
      {
        $("input[id$='txtRelationName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getRelation()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getRelations",
            data: "{}", 
            success:onsuccessgetRelation,
            error:onretrievegetRelation 
        });
        return false; 
      }
      function onsuccessgetRelation(msg)
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Rank ID</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Relation Name</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.RelationDetail.length; i++) {                   
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteRankRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.RelationDetail[i].relation_id + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtRelationName" + i + "'>" + data.RelationDetail[i].relation_name + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.RelationDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.RelationDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.RelationDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.RelationDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblRelationDetails").html(tbl);
                dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='tblRelationDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetRelation()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteRankRecord(rowNo) {
          

          var Relation_ID = $("#txtID" + rowNo).html();
          
              if (confirm("Are you sure you wish to delete this Record?")) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "Settingwebmethods.aspx/DeleteRelation",
                      data: "{'Relation_ID':'" + Relation_ID + "'}",
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
          getRelation();
          return false;

      }

      function OnretrievePhysicianError(msg) {
         // getRelationalRecod();
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

          var DEPT_NAME = $("#txtRelationName"+rowNo).html().trim();
          $("input[id$='txtRelationName']").val(DEPT_NAME);
          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateRank()
      {
          var Relation_ID = $("input[id$='txtID']").val();

          var Relation_Name = $("input[id$='txtRelationName']").val();
         
          if (Relation_Name == "")
            {
                alert("Please Enter Relation!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/UpdateRelation",
            data: "{'Relation_ID':'" + Relation_ID + "','Relation_Name':'" + Relation_Name + "'}",
            success:onsuccessUpdateRanks,
            error:onretrieveUpdateRanks 
        });
        return false; 
      }
      function onsuccessUpdateRanks()
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Updated!");
          $("#divSuccessMsg").fadeOut(6000);
          $("input[id$='txtRelationName']").val("");
          getRelation();

        ClearRank();
        getRelation();
        return false;
      }
      function onretrieveUpdateRanks()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>

