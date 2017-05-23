var _currentDate = "";

//$( document ).ready(function() {
//$('#cssmenu li.has-sub>a').on('click', function(){
//		$(this).removeAttr('href');
//		var element = $(this).parent('li');
//		if (element.hasClass('open')) {
//			element.removeClass('open');
//			element.find('li').removeClass('open');
//			element.find('ul').slideUp();
//		}
//		else {
//			element.addClass('open');
//			element.children('ul').slideDown();
//			element.siblings('li').children('ul').slideUp();
//			element.siblings('li').removeClass('open');
//			element.siblings('li').find('li').removeClass('open');
//			element.siblings('li').find('ul').slideUp();
//		}
//	});

//	$('#cssmenu>ul>li.has-sub>a').append('<span class="holder"></span>');

//	(function getColor() {
//		var r, g, b;
//		var textColor = $('#cssmenu').css('color');
//		textColor = textColor.slice(4);
//		r = textColor.slice(0, textColor.indexOf(','));
//		textColor = textColor.slice(textColor.indexOf(' ') + 1);
//		g = textColor.slice(0, textColor.indexOf(','));
//		textColor = textColor.slice(textColor.indexOf(' ') + 1);
//		b = textColor.slice(0, textColor.indexOf(')'));
//		var l = rgbToHsl(r, g, b);
//		if (l > 0.7) {
//			$('#cssmenu>ul>li>a').css('text-shadow', '0 1px 1px rgba(0, 0, 0, .35)');
//			$('#cssmenu>ul>li>a>span').css('border-color', 'rgba(0, 0, 0, .35)');
//		}
//		else
//		{
//			$('#cssmenu>ul>li>a').css('text-shadow', '0 1px 0 rgba(255, 255, 255, .35)');
//			$('#cssmenu>ul>li>a>span').css('border-color', 'rgba(255, 255, 255, .35)');
//		}
//	})();

//	function rgbToHsl(r, g, b) {
//	    r /= 255, g /= 255, b /= 255;
//	    var max = Math.max(r, g, b), min = Math.min(r, g, b);
//	    var h, s, l = (max + min) / 2;

//	    if(max == min){
//	        h = s = 0;
//	    }
//	    else {
//	        var d = max - min;
//	        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
//	        switch(max){
//	            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
//	            case g: h = (b - r) / d + 2; break;
//	            case b: h = (r - g) / d + 4; break;
//	        }
//	        h /= 6;
//	    }
//	    return l;
//	}
//});

$(document).ajaxStart(blockUI).ajaxStop(unblockUI);
$.ajaxSetup({
    error: function (XMLHttpRequest, textStatus, errorThrown) {
        
            alert("Some error occurred.Please try again!");        
    }
});
function blockUI() {
    $.blockUI({
        message: '<img src="images/ajax-loader.gif" />',
        css: { borderStyle: 'none', backgroundColor: "Transparent" }
    });
}
function unblockUI() {
    $.unblockUI();
}
function validate(formId)
{
  
    var isError = false;
    $("#" + formId + " .req").each(function () {
        if ($.trim($(this).val()) == "" || $.trim($(this).val()) == "-- Select --")
        {
            isError = true;            
        }        
    });
    if (isError)
        showErrorMsg("Please enter all required fields!");        

    return isError;
}
function showErrorMsg(msg) {
    $("#divMsg").html(msg).addClass("error").removeClass("success").show().fadeOut(4000);
}
function showSuccessMsg(msg) {
    $("#divMsg").html(msg).addClass("success").removeClass("error").show().fadeOut(4000);
}

$(document).ready(function () {    
    $(".phone").mask("(999) 999-9999");
    $(".time").mask("99:99", { placeholder: "hh:mm" });//.mask('hh:mm');
    $(".cell").mask("(9999) 999-9999");
    $(".date").mask("99/99/9999", { placeholder: "mm/dd/yyyy" });
    $(".cnic").mask("99999-9999999-9");
    //$("input[type='text']").not($("input[id$='txtEmail']")).not($("input[id$='txtPassword']")).keypress(function (e) {
    //    var regex = new RegExp("^[a-zA-Z0-9 -]+$");
    //    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    //    if (regex.test(str)) {
    //        return true;
    //    }

    //    e.preventDefault();
    //    return false;
    //});

    $(".alpha").keypress(function (e) {
        var regex = new RegExp("^[a-zA-Z ]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }

        e.preventDefault();
        return false;
    });
    
    //-----------------------function use for numeric textboxes only---------------------------
    $(".numeric").keypress(function (e) {

        var regex = new RegExp("^[0-9 -]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if(regex.test(str))
        {
            return true;
        }

        e.preventDefault();
        return false;


    });

    //------------------------- function use for address textboxes only------------------

    $(".address").keypress(function (e) {

        var regex = new RegExp("^[a-zA-Z0-9 -#.]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }

        e.preventDefault();
        return false;


    });
    //------------------------- function use for password textboxes only------------------

    $(".password").keypress(function (e) {

        var regex = new RegExp("^[a-zA-Z0-9 -#@!$%^&*]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }

        e.preventDefault();
        return false;


    });
    //------------------------- function use for alphanumeric textboxes only------------------

    $(".alphanumeric").keypress(function (e) {
        //  alert(e.keyCode);
        if (e.keyCode != 8){
        var regex = new RegExp("^[a-zA-Z0-9 -]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }

        e.preventDefault();
        return false;
        }

    });

    //$('##body').bind('cut copy paste drop', function (e) {
    //    e.preventDefault();
    //});


    $(".email").blur(function (e) {
        var str = $(".email").val().trim();
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!re.test(str) && str !=="")
        {
            alert("Please enter a valid email address");
            $(".email").val("");
            $(".email").focus();
        }
            
    });

});

function getQueryStringValue() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}
function calculateCurrentDate() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;//January is 0!`

    var yyyy = today.getFullYear();
    if (dd < 10) { dd = '0' + dd }
    if (mm < 10) { mm = '0' + mm }
    _currentDate = dd + '/' + mm + '/' + yyyy;
    return _currentDate;
}

