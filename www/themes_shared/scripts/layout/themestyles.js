function initthemes(initialurl) {
    if ($('#themelist').length == 0) {
        return;
    }
    if (!$('#themelist').jqxDropDownList) {
        return;
    }
    var loadedThemes = [
        0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1
    ];
    var themes = [
        { label: 'Arctic', group: 'Themes', value: 'arctic' },
        { label: 'Web', group: 'Themes', value: 'web' },
        { label: 'Bootstrap', group: 'Themes', value: 'bootstrap' },
        { label: 'Metro', group: 'Themes', value: 'metro' },
        { label: 'Metro Dark', group: 'Themes', value: 'metrodark' },
        { label: 'Office', group: 'Themes', value: 'office' },
        { label: 'Orange', group: 'Themes', value: 'orange' },
        { label: 'Fresh', group: 'Themes', value: 'fresh' },
        { label: 'Energy Blue', group: 'Themes', value: 'energyblue' },
        { label: 'Dark Blue', group: 'Themes', value: 'darkblue' },
        { label: 'Black', group: 'Themes', value: 'black' },
        { label: 'Shiny Black', group: 'Themes', value: 'shinyblack' },
        { label: 'Classic', group: 'Themes', value: 'classic' },
        { label: 'Summer', group: 'Themes', value: 'summer' },
        { label: 'High Contrast', group: 'Themes', value: 'highcontrast' },
        { label: 'Lightness', group: 'UI Compatible', value: 'ui-lightness' },
        { label: 'Darkness', group: 'UI Compatible', value: 'ui-darkness' },
        { label: 'Smoothness', group: 'UI Compatible', value: 'ui-smoothness' },
        { label: 'Start', group: 'UI Compatible', value: 'ui-start' },
        { label: 'Redmond', group: 'UI Compatible', value: 'ui-redmond' },
        { label: 'Sunny', group: 'UI Compatible', value: 'ui-sunny' },
        { label: 'Overcast', group: 'UI Compatible', value: 'ui-overcast' },
        { label: 'Le Frog', group: 'UI Compatible', value: 'ui-le-frog' }
    ];
    var me = this;
    this.$head = $('head');
    $('#themelist').jqxDropDownList({ source: themes, selectedIndex: 0, dropDownHeight: 200, height: '20px' });
    var hasParam = window.location.toString().indexOf('#css=');
    if (hasParam != -1) {
        var theme = window.location.toString().substring(hasParam + 5);
        $.data(document.body, 'theme', theme);
        selectedTheme = theme;
        var themeIndex = 0;
        $.each(themes, function (index) {
            if (this.value == theme) {
                themeIndex = index;
                return false;
            }
        });
        $('#themelist').jqxDropDownList({ theme: theme, selectedIndex: themeIndex, width: '175px'});
        loadedThemes[0] = -1;
        loadedThemes[themeIndex] = 0;
    }
    else {
	    var theme = checkCookie();
        $.data(document.body, 'theme', theme);
        window.location = window.location.toString() + "#css=" + theme;
	    location.reload();
    }
    $('#themelist').on('select', function (event) {
        setTimeout(function () {
            var selectedIndex = event.args.index;
            var selectedTheme = '';
            var url = initialurl;
            var loaded = loadedThemes[selectedIndex] != -1;
            loadedThemes[selectedIndex] = selectedIndex;
            var themes = [
                { label: 'Arctic', group: 'Themes', value: 'arctic' },
                { label: 'Web', group: 'Themes', value: 'web' },
                { label: 'Bootstrap', group: 'Themes', value: 'bootstrap' },
                { label: 'Metro', group: 'Themes', value: 'metro' },
                { label: 'Metro Dark', group: 'Themes', value: 'metrodark' },
                { label: 'Office', group: 'Themes', value: 'office' },
                { label: 'Orange', group: 'Themes', value: 'orange' },
                { label: 'Fresh', group: 'Themes', value: 'fresh' },
                { label: 'Energy Blue', group: 'Themes', value: 'energyblue' },
                { label: 'Dark Blue', group: 'Themes', value: 'darkblue' },
                { label: 'Black', group: 'Themes', value: 'black' },
                { label: 'Shiny Black', group: 'Themes', value: 'shinyblack' },
                { label: 'Classic', group: 'Themes', value: 'classic' },
                { label: 'Summer', group: 'Themes', value: 'summer' },
                { label: 'High Contrast', group: 'Themes', value: 'highcontrast' },
                { label: 'Lightness', group: 'UI Compatible', value: 'ui-lightness' },
                { label: 'Darkness', group: 'UI Compatible', value: 'ui-darkness' },
                { label: 'Smoothness', group: 'UI Compatible', value: 'ui-smoothness' },
                { label: 'Start', group: 'UI Compatible', value: 'ui-start' },
                { label: 'Redmond', group: 'UI Compatible', value: 'ui-redmond' },
                { label: 'Sunny', group: 'UI Compatible', value: 'ui-sunny' },
                { label: 'Overcast', group: 'UI Compatible', value: 'ui-overcast' },
                { label: 'Le Frog', group: 'UI Compatible', value: 'ui-le-frog' }
            ];
            selectedTheme = themes[selectedIndex].value;
	        setCookie("theme", selectedTheme, 365);
             window.location.replace(window.location.protocol + "//" + window.location.host + window.location.pathname + "#css=" + selectedTheme);
	        window.location.reload();
        }, 5);
    });
};

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires=" + d.toUTCString();
	document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') c = c.substring(1);
		if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
	}
	return "";
}

function checkCookie() {
	var cookietheme = getCookie("theme");
	if (cookietheme != "") {
		theme = cookietheme;
		return cookietheme;
	} else {
		setCookie("theme", 'artic', 365);
		return 'artic';
	}
}

function getTheme() {
    var theme = document.body ? $.data(document.body, 'theme') : null
    if (theme == null) {
        theme = '';
    }
    else {
        return theme;
    }
    var themestart = window.location.toString().indexOf('#css=');
    if (themestart == -1) {
        return '';
    }

    var theme = window.location.toString().substring(5 + themestart);
    var url = "/admin/../themes_shared/styles/layout/jqx." + theme + '.css';

    if (document.createStyleSheet != undefined) {
        var hasStyle = false;
        $.each(document.styleSheets, function (index, value) {
            if (value.href != undefined && value.href.indexOf(theme) != -1) {
                hasStyle = true;
                return false;
            }
        });
        if (!hasStyle) {
            document.createStyleSheet(url);
        }
    }
    else {
        var link = $('<link rel="stylesheet" href="' + url + '" media="screen" />');
        link[0].onload = function () {
            if ($.jqx && $.jqx.ready) {
                $.jqx.ready();
            };
        }
        $(document).find('head').append(link);
    }
    $.jqx = $.jqx || {};
    $.jqx.theme = theme;
    return theme;
};
var theme = '';
try
{
    if (jQuery) {
        theme = getTheme();
    }
    else {
        $(document).ready(function () {
            theme = getTheme();
        });
    }
}
catch (error) {
    var er = error;
}
