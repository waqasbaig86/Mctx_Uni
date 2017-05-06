<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="City.aspx.cs" Inherits="SettingForms_City" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified City</legend>

                    <table id="tblcity" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">City Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtCityName" Width="95%" placeholder="City Name"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveCity();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return ClearCity();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateCity();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divCityDetails">
        <fieldset id="fldCityDetails" >
            <legend>City Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleCityDetails" class="dataTable">
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
            //getCaste();
            getCity();

        });

        function dataTable() {
            oTable = $("#tbleCityDetails").dataTable();
        }

        function SaveCity() {
            var i = 0;
            if ($("#tbleCityDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleCityDetails tr").length - 1; i++) {

                    if ($("#txtCityName" + i).html().toUpperCase().trim() == $("input[id$='txtCityName']").val().toUpperCase().trim()) {
                        alert("City " + $("input[id$='txtCityName']").val() + " is already added!");
                        $("input[id$='txtCityName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tbleCityDetails")) {
                var City_Name = $("input[id$='txtCityName']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveCity",
                    data: "{'City_Name':'" + City_Name + "'}",
                    success: onsuccessSaveCity
                });
            }
            return false;
        }
        function onsuccessSaveCity(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtCityName']").val("");
            getCity();
            return false;
        }
        function ClearCity() {
            $("input[id$='txtCityName']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getCity() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getCityDetail",
                data: "{}",
                success: onsuccessgetCity
            });
            return false;
        }
        function onsuccessgetCity(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>City ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>City Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.CityDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteCityRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.CityDetail[i].city_id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCityName" + i + "'>" + data.CityDetail[i].city_name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.CityDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.CityDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CityDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CityDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleCityDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleCityDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteCityRecord(rowNo) {

            var City_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteCity",
                    data: "{'City_ID':'" + City_ID + "'}",
                    success: onsuccessDeleteData,
                    error: onerror
                });

                return false;
            }
            else
                return false;
        }

        function onerror(xhr) {
            $(".alert").html(xhr.responseText);

        }
        function onsuccessDeleteData(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
             getCity();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var City_Name = $("#txtCityName" + rowNo).html().trim();
            $("input[id$='txtCityName']").val(City_Name);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateCity() {
            if (!validate("tblCity")) {
                var City_ID = $("input[id$='txtID']").val();
                var City_Name = $("input[id$='txtCityName']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateCity",
                    data: "{'City_ID':'" + City_ID + "','City_Name':'" + City_Name + "'}",
                    success: onsuccessUpdateCity
                });
            }
            return false;
        }
        function onsuccessUpdateCity() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtCityName']").val("");
            getCity();

            ClearCity();
           
            return false;
        }
    </script>
</asp:Content>

