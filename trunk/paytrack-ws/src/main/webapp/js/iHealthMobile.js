var globalTapReady = true; // NOTE: this var must be added to jQuery Mobile's handleTouchEnd() in order to prevent premature trigger of tap events
var orient; // 'portrait' or 'landscape', not to be confused with window.orientation which is not supported by all mobile devices
var droid = !!(navigator.userAgent.match(/Android/));
var ios = !!(navigator.userAgent.match(/iPhone/) || navigator.userAgent.match(/iPod/));
//var safari = navigator.userAgent.match(/Gecko\)\sVersion\/\d\.\d/);
//if (safari) safari = safari[0].match(/\d\.\d/)[0] * 10;
var preloadImages = [];
var touchOverflow = $.support.touchOverflow && $.mobile.touchOverflowEnabled;
var jsScroller = ((ios || droid) && !touchOverflow); // enable native-like scrolling for iOS and Android 
var showFeedback = false;

// hide URL bar
function scrollUp() {
	scrollTo(0, droid? 1 : 0);
};

$.extend( $.mobile, {
	loadingMessage: "Loading..."
});

// scroll content to top
function scrollPageTop() {
    if (jsScroller) {
		$('.scrollPanel').filter(':visible').vTouchScrollTo(0);
	}else {
		scrollUp();
	}
};

// returns screen height - copied from jQuery Mobile to make it global
function getScreenHeight() {
	var port			= orient === "portrait",
		winMin			= port ? 480 : 320,
		screenHeight	= port ? screen.availHeight : screen.availWidth,
		winHeight		= Math.max( winMin, $( window ).height() ),
		pageMin			= Math.min( screenHeight, winHeight );

	return pageMin;
};

// set's the height of scrollable panels for iOS
function setScrollPanelHeight(jScroll) {
	if (!jsScroller) return;
	
	var jScroll = jScroll || $('.scrollPanel'), screenH = getScreenHeight(), h = screenH - 46;
	if (ios && !window.navigator.standalone) h -= (orient === 'portrait' ? 42 : 50);
    if (droid && screenH > document.documentElement.offsetHeight) h -= 24;
	jScroll.css('height', h).filter(':visible').vTouchScrollCheckBounds();
};

// init a page for js scroller before JQM enhances it
function initPageScrolling(page) {
    var scroll = page.find('.scrollPanel'),
    	header = page.find('div[data-role="header"]').filter('[data-position="fixed"]');

    if (scroll.length) {
    	if (header.length) header.removeAttr('data-position');
    	if (page.attr('id') == 'msgInbox') {
    	    scroll.vTouchScroll({triggerTap:false, triggerSwipe:false, friction:.06, pullRefresh:true});
    	    scroll.bind('pullrefresh', function(e, hasDoneRefresh) {
    	        setTimeout(function() {
    	            inboxUpdated();
    	            hasDoneRefresh();
    	        }, 1800);
    	    });
    	}else {
    	    scroll.vTouchScroll({triggerTap:false, triggerSwipe:false, friction:.06, pullRefresh:false});
    	}
    	setScrollPanelHeight(scroll);
    }
};


$(document).ready(function() {
	if (jsScroller) {
		$('body').addClass('jsScroller');
		
		$(document).bind('touchstart', function() {
			if ($('.scrollPanel').filter(':visible').length) scrollUp();

		// }).bind('touchmove', function(e) {
		//	if ($('.scrollPanel').filter(':visible').length) return false;
		
		}).bind('pagebeforecreate', function(e) {
			var page = $(e.target);
			if (page[0].id != 'home') initPageScrolling(page);
		});
		// JQM 1.0 does not trigger 'pagebeforecreate' on the first page, '#home'. Is this a bug?
		initPageScrolling($('#home'));
	}else {
	    if (touchOverflow) $('#home').find('div[data-role="content"]').css('padding-top', 60).unwrap();
	}
	
	$(window).bind('orientationchange', function(e) {
		// when window.orientationchange is not natively supported this event is bound to onresize. since scrollTo() 
		// can trigger onresize we need to prevent the following code from continuous execution
		if (orient === e.orientation) return;
		orient = e.orientation;
		setScrollPanelHeight();
		setTimeout(scrollUp, 1);
		
	}).trigger('orientationchange');
	

	if (ios) {
		$('#signout, #signin').attr('data-transition', 'flip'); // flip looks terrible on Android so default to slide
		if (navigator.standalone === false) {
		    setTimeout(function() {
		        $('#addToHome').css({'visibility':'visible', 'webkitTransform':'translate3d(0,0,0)'});
		        //setTimeout(function() {$('#addToHome').click()}, 8000);
		    }, 1800);
		}
	}
	
	$('body').delegate('li.more a', 'click', function() {
		moreMessages();
		return false;
	}).delegate('a.refresh', 'click', function() {
		refreshInbox();
		return false;
	});

	// using event deligation for better performance
	$(document.body).delegate('a', 'click', function() {
	    var link = $(this),
	        id = this.id,
	        tappable = link.closest('.tappable');
	    
	    // Touch framework enhancement to highlight the container of a tapped element. Adds a 'tapactive' class if the container is '.tappable'
        if (tappable.length) {
            tappable.addClass('tapactive');
            setTimeout(function() {
                try {
                    tappable.removeClass('tapactive');
                }catch(e){}
            }, 2000);
            /*
			tappable.addClass('tapactive').closest('.ui-page').one('pagehide', function() {
				tappable.removeClass('tapactive');
			});*/
		}
	    
	    // quick and dirty way of removing unread flag on inbox
	    link.closest('li').removeClass('unread');
	    
	    if (link.attr('submit')) {
	        link.closest('form').submit();
	    }
	    
	    switch (id) {
	    case 'inboxMore':
	        moreMessages();
	        break;
	    case 'inboxRefresh':
	        refreshInbox();
	        break;
	    case 'btnSendReply':
	      //  link.closest('div[data-role="page"]').find('form').submit();
	        break;
	    case 'chkContactMe':
	        toggleContactMe(link);
	        break;
	    case 'selProviderDone':
	        var radio = $('input[name="provider"]:checked');
	        if (radio.length) $('#selProvider').text(radio.next().text());
    	    break;
    	case 'selPharmacyDone':
    	    var radio = $('input[name="pharmacy"]:checked');
    	    if (radio.length) {
    	        $('#selPharmacy').text(radio.next().text());
    	        $('#scanBlock').css('display', 'block');
    	    }
        	break;
        case 'addToHome':
            link.css('webkitTransform','translate3d(0,100px,0)');
            break;
            
        case 'signout':
            showFeedback = true;
            //$.mobile.changePage($('#feedback'), { transition: 'slideup'});
            //$.mobile.changePage($('#login'), { transition: ios? 'flip':'slideup', reverse: true});
            break;
	    }
	
	}).bind('pagecreate', function(e) {
	    var page = $(e.target), id = page.attr('id');
	    
	    if (touchOverflow) {
	        var content = page.find('div[data-role="content"]'), header = page.find('div[data-role="header"]');
	        if (content.parent().hasClass('scrollPanel')) content.unwrap();
	        if (header.attr('data-position') == 'fixed') content.css('padding-top', 60);
	    }
	    
	    switch (id) {
	    case 'rxDlg':
	        //var pharma = $('input[name="pharma"]:checked');
	        //if (pharma.length) $('#pharmacyName').text(pharma.next().text());
	    case 'apptDlg':
	        // modify the dialog close button behavior so that it goes home instead of back
	        setTimeout(function() {
	            page.find('a').eq(0).attr('href', '#apptMain').removeAttr('data-rel');
	        }, 1);
	        break;
	    case 'feedbackThanks':
	        // modify the dialog close button behavior so that it goes home instead of back
	        setTimeout(function() {
	            page.find('a').eq(0).attr('href', '#login').removeAttr('data-rel');
	        }, 1);
	        break;
	    case 'msgDetails':
	        createMsgReply(page);
	        break;
	    case 'rxRefill':
	        var label = page.find('label:contains("' + curRx + '")');
	        if (label.length) page.find('input[id="' + label.attr('for') + '"]')[0].checked = true;
	        break;
	    case 'msgInbox':
	        inboxUpdated();
	        break;
	    }
	    
	}).bind('pageshow', function(e) {
	    var page = $(e.target), id = page.attr('id');
	    
	    switch (id) {
	    case 'home':
	        // $('#msgInbox').remove(); // remove the inbox from the DOM forcing an implicit refresh when "messages" is tapped on the home screen
	        $('#apptNew, #apttMain').remove(); // clean up the DOM
	        break;
	    case 'msgInbox':
	        $('#msgReply, #msgDetails').remove(); // clean up the DOM
	        $('#nav_msg').attr('href', '#msgInbox'); // ensure caching of inbox
	        break;
	    case 'msgReply':
	        page.find('textarea').val(''); // .focus(); // does not currently display the virtual keyboard and only hides the placeholder text
	        break;
	    case 'rx':
	        $('#rxRefillNew').remove(); // clean up the DOM
	        break;
	    case 'login':
	        if (showFeedback) {
	            showFeedback = false;
	            $.mobile.changePage($('#feedback'), { transition: 'slideup'});
	        }
	        break;
	    }
	
	}).bind('pagebeforeshow', function(e) {
	    var page = $(e.target), id = page.attr('id');
	    
	    switch (id) {
	    case 'feedback':
	       // page.find('.formError').hide();
	        $('#stars').touchStar_reset();
	        page.find('textarea').val('');
	        break;
	    case 'rxDetail':
	        page.find('h1.small').text(curRx);
	        break;
	    case 'apptDlg':
	        $('body').addClass('appt_scheduled');
            break;
    	case 'rxDlg':
    	    $('body').addClass('rx_renewed');
	        break;
	    }
	    
	}).bind('pagebeforehide', function(e) {
	    var page = $(e.target), id = page.attr('id');
	    
	    switch (id) {
	    case 'home':
	        $('#addToHome').css('display', 'none');
	        break;
	    }

	}).bind('submit', function(e) {
	    var form = $(e.target), id = form.attr('id'), action = form.attr('action'); //, method = form.attr('method');
	    
	    switch (id) {
	    case 'feedbackForm':
	        var nps = $('#nps').touchNPS_val();
	        if (!nps.length) {
	            form.find('.formError').show();
	            return false;
	        }else {
	            form.find('.formError').hide();
	        }
	        $.mobile.showPageLoadingMsg();
            $.get(action, function(data) {
               //assume response is ok
               $.mobile.changePage($('#feedbackThanks'));
               $.mobile.hidePageLoadingMsg();
               form.find('input, textarea').val('');
            });
            return false;
            
        case 'newApptForm':
            $.mobile.changePage('apptDlg.html');
            return false;
        case 'rxAddForm':
            $.mobile.changePage('rxMain.html', { transition: 'slideup', reverse: true});
            return false;
        case 'searchDocForm':
            hideKeyboard();
            $('#docSearchResults').show();
            return false;
	    }
	    
	}).bind('change', function(e) {
	    var select = $(e.target), id = select.attr('id'), selIndex = e.target.selectedIndex;
	    
	    switch (id) {
	    case 'selApptDate':
    	    var now = new Date(), y = now.getFullYear(), m = now.getMonth() + 1, d = now.getDate(), dateField = $('#preferredDate');
        
            if (d < 10) d = '0' + d;
            if (m < 10) m = '0' + m;
            if (!dateField.val()) dateField.val(y + '-' + m + '-' + d);
	        dateField.css('display', selIndex == 0 ? 'none':'block');
	        break;
	    }
	});
	
	/* removed for 11.4
	$('#msgSearch').live('click', showHideMsgSearch);
	$('#msgSearchField').live('focus', scrollUp);
    */
    
    /* appointments */
    /*
    $('#location').live('change', function(e) {
        $('#apptProvider').css('display', 'none');
        if (this.selectedIndex > 0) {
            $('html').addClass('ui-loading');
            $('#provider')[0].selectedIndex = 0;
            setTimeout(function() {
                $('html').removeClass('ui-loading');
                $('#apptProvider').css('display', 'block');
                $('#provider').selectmenu("refresh");
            }, 1000);
        }
        scrollUp();
    });*/
    $('#newApptNext').live('click', function(e) {
        var radio = $(':radio:checked');
        
        if (!radio.length) {
            $('#apptNew .formError').css('display','block');
        }else if(radio.val() == 'search') {
            $.mobile.changePage('searchDoc.html');
        }else if(radio.val() == '0') {
            $.mobile.changePage('selApptLocation.html');
        }else {
            $.mobile.changePage('apptNew2.html');
        }
        return false;
    });
    
    $('#searchDocDone, #searchDocDone2').live('click', function() {
       $.mobile.changePage('apptNew2.html');
       return false; 
    });
    /* end appointments */
    
    /* rx */
    var curRx = 'Insulin, Humalog';
    $('#rx').live('click', function(e) {
        var targ = e.target;
        if (targ.nodeName == 'A') {
            curRx = $(targ).text();
        }
    });
    
    $('#scanBtn').live('click', function(e) {
        window.plugins.barcodeScanner.scan(
            function(result) {
                if (result.cancelled) {
                   // alert("the user cancelled the scan")
                }else {
                    $('#rxNumber').val(result.text);
                    //alert("we got a barcode: " + result.text)
                }
            },
            function(error) {
                // alert("scanning failed: " + error)
            }
        );
        return false;
    });
    /* end rx */
    
    /*
    $('#nps').touchNPS().bind('change', function() {
        $(this).closest('div[data-role="page"]').find('.formError').hide();
    });*/
    $('#stars').touchStar();
    $('#feedback textarea').bind('focusout', scrollUp);
    
    loadImages();
});

// hide the virtual keyboard
function hideKeyboard() {
    setTimeout(function() {
        try {
            $.mobile.activePage.find(':button, a').focus();
        }catch(e) {}
    }, 1);
}

function loadImages() {
	for (var i = 0, n = preloadImages.length; i < n; i++) {
		(new Image()).src = preloadImages[i];
	}
}

function inboxUpdated() {
    var now = new Date();
    $('#inboxLastUpdate').text('Last updated: ' + now.format('m/d/yy h:MM TT'));
}

// create the reply to message page when the message details page is loaded
function createMsgReply(page) {
    var newPage = page.clone(), links = newPage.find('a'), subject = newPage.find('.messageSubject').eq(0).text(), content = newPage.find('div[data-role="content"]');
    
    page.find('form').remove();
    newPage.attr('id', 'msgReply').attr('data-url', 'msgReply');
    if (content.parent().hasClass('scrollPanel')) {
        content.unwrap(); // remove .scrollPanel
    }
    if (!touchOverflow) newPage.find('div[data-role="header"]').removeAttr('data-position');
    newPage.find('h1').eq(0).removeClass('small').text('Reply');
    links.eq(0)
    	.text('Cancel')
    	.removeAttr('data-rel')
    	.attr('data-transition', 'slideup')
    	.attr('data-direction', 'reverse')
    	.removeClass('force_back')
    	.removeAttr('data-icon').attr('href', '#msgDetails');

    links.eq(1).text('Send').attr('href', '#').attr('id', 'btnSendReply');
    newPage.appendTo($('body'));
}

// "show more messages" event handler
function moreMessages() {
    var moreLink = $('#inboxMore'), loadingMsg = $('#inboxLoading'), container = $('#ajaxContent'), listData;
    moreLink.css('display', 'none');
    loadingMsg.find('h1').text('Loading...');
    loadingMsg.css('display', 'block');
    container.empty().one('pagecreate', function() {
        // seems to be a timing issue...
        setTimeout(function() {
	        listData = container.find('ul').html();
	        container.empty();
	        $('#msgInbox ul li').filter(':last').before(listData);
	        moreLink.css('display', 'block');
    	    loadingMsg.css('display', 'none');
	    }, 10);
    });
    $.mobile.loadPage('msgMore.html', { pageContainer: container });
    return false;
}

// refresh message inbox
function refreshInbox() {
    $.mobile.showPageLoadingMsg();
    setTimeout(function() {
        $('#msgInbox li:gt(9)').not('li:last').remove();
        scrollPageTop();
        $.mobile.hidePageLoadingMsg();
    }, 1000);
}

// called when #msgSearch is tapped
function showHideMsgSearch() {
	var searchBox = $('#msgSearchBox'), jScroll = searchBox.closest('.scrollPanel'), searchIcon = $('#msgSearch .ui-icon');
	
	searchIcon.removeClass('ui-icon-search ui-icon-delete');
	if (searchBox.css('display') == 'block') {
		searchBox.css('display', 'none').find('input').val('').trigger('keyup');
		searchIcon.addClass('ui-icon-search');
		if (jsScroller) {
			setTimeout(function() {jScroll.vTouchScrollCheckBounds()}, 1);
		}
	}else {
		searchBox.css('display', 'block');
		searchIcon.addClass('ui-icon-delete');
		setTimeout(scrollPageTop, 1);
	}
}

function toggleContactMe(link) {
    link.toggleClass('checked');
    var checked = link.hasClass('checked');
    //$('#contactEmail').css('display', checked? 'block':'none');
    link.find('input').val(checked);
}

/* jQuery plugin for touch optimized app star rating */
function TouchStar(el, opt) {
    var jthis = $(el).addClass('stars'), hidden;
    
    init();
    
    /* private methods */
    function init() {
        for (var i = 1; i < 6; i++) {
            $('<div></div>').attr('value', i).appendTo(jthis);
        }
        if ('ontouchstart' in document) {
            jthis.bind('touchstart', rate).bind('touchmove', rate);
        }else {
            jthis.click(rate);
        }
        $('<label>Tap a Star to Rate</label>').appendTo(jthis);
        if (jthis.attr('name')) {
            hidden = $('<input type="hidden" />').attr('name', jthis.attr('name')).appendTo(jthis);
            jthis.removeAttr('name');
        }
    }
    function rate(e) {
        var event = e.originalEvent, $el, touch;

        if (event.changedTouches && event.changedTouches.length && 'elementFromPoint' in document) {
           touch = event.changedTouches[0];
           $el = $(document.elementFromPoint(touch.pageX , touch.pageY)).closest('.stars>div');
        }else {
           $el = $(event.target).closest('.stars>div');
        }
        if ($el.length) {
            if (hidden) hidden.val($el.attr('value'));
            jthis.find('label').css('opacity', 0);
            $el.addClass('sel').siblings().removeClass('sel');
            $el = $el.prev();
            while ($el.length) {
                $el.addClass('sel');
                $el = $el.prev();
            }
            jthis.trigger('change');
        }
        return false;
    }
    
    /* public methods */
    this.reset = function () {
        if (hidden) hidden.val('');
        jthis.find('label').css('opacity', 1).end().find('div.sel').removeClass('sel');
        jthis.trigger('change');
    }
    this.val = function() {
        return jthis.find('div.sel').length;
    }
}
$.fn.extend({
    touchStar: function() {
		return this.each(function() {
			if (!$(this).data('touchStar')) {
				$(this).data('touchStar', new TouchStar(this));
			}
		});
	},
    touchStar_reset: function() {
    	return this.each(function() {
    		$(this).data('touchStar').reset();
    	});
    },
    touchStar_val: function() {
        return $(this).eq(0).data('touchStar').val();
    }
});
/* end jQuery plugin for touch optimized app star rating widget */


function deleteCookie(sName) {
    document.cookie = sName + "=" + "" + "; expires=Fri, 31 Dec 1999 23:59:59 GMT;";
}
function setCookie(sName, sValue, days) {
    var date = new Date();
    if (days==undefined) days = 30;
    var m = date.getTime() + days * 24 * 60 * 60 * 1000;
    date = new Date(m);
    document.cookie = sName + "=" + escape(sValue) + "; expires=" + date.toGMTString();
}
function getCookie(sName) {
    var aCookie = document.cookie.split("; "); 
    for (var i=0; i<aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0]) 
            return unescape(aCrumb[1]);
    }
    return null;
}


/*
 * Date Format 1.2.3
 * (c) 2007-2009 Steven Levithan <stevenlevithan.com>
 * MIT license
 *
 * Includes enhancements by Scott Trenda <scott.trenda.net>
 * and Kris Kowal <cixar.com/~kris.kowal/>
 *
 * Accepts a date, a mask, or a date and a mask.
 * Returns a formatted version of the given date.
 * The date defaults to the current date/time.
 * The mask defaults to dateFormat.masks.default.
 * http://blog.stevenlevithan.com/archives/date-time-format
 */

var dateFormat = function () {
	var	token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
		timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
		timezoneClip = /[^-+\dA-Z]/g,
		pad = function (val, len) {
			val = String(val);
			len = len || 2;
			while (val.length < len) val = "0" + val;
			return val;
		};

	// Regexes and supporting functions are cached through closure
	return function (date, mask, utc) {
		var dF = dateFormat;

		// You can't provide utc if you skip other args (use the "UTC:" mask prefix)
		if (arguments.length == 1 && Object.prototype.toString.call(date) == "[object String]" && !/\d/.test(date)) {
			mask = date;
			date = undefined;
		}

		// Passing date through Date applies Date.parse, if necessary
		date = date ? new Date(date) : new Date;
		if (isNaN(date)) throw SyntaxError("invalid date");

		mask = String(dF.masks[mask] || mask || dF.masks["default"]);

		// Allow setting the utc argument via the mask
		if (mask.slice(0, 4) == "UTC:") {
			mask = mask.slice(4);
			utc = true;
		}

		var	_ = utc ? "getUTC" : "get",
			d = date[_ + "Date"](),
			D = date[_ + "Day"](),
			m = date[_ + "Month"](),
			y = date[_ + "FullYear"](),
			H = date[_ + "Hours"](),
			M = date[_ + "Minutes"](),
			s = date[_ + "Seconds"](),
			L = date[_ + "Milliseconds"](),
			o = utc ? 0 : date.getTimezoneOffset(),
			flags = {
				d:    d,
				dd:   pad(d),
				ddd:  dF.i18n.dayNames[D],
				dddd: dF.i18n.dayNames[D + 7],
				m:    m + 1,
				mm:   pad(m + 1),
				mmm:  dF.i18n.monthNames[m],
				mmmm: dF.i18n.monthNames[m + 12],
				yy:   String(y).slice(2),
				yyyy: y,
				h:    H % 12 || 12,
				hh:   pad(H % 12 || 12),
				H:    H,
				HH:   pad(H),
				M:    M,
				MM:   pad(M),
				s:    s,
				ss:   pad(s),
				l:    pad(L, 3),
				L:    pad(L > 99 ? Math.round(L / 10) : L),
				t:    H < 12 ? "a"  : "p",
				tt:   H < 12 ? "am" : "pm",
				T:    H < 12 ? "A"  : "P",
				TT:   H < 12 ? "AM" : "PM",
				Z:    utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
				o:    (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
				S:    ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
			};

		return mask.replace(token, function ($0) {
			return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
		});
	};
}();

// Some common format strings
dateFormat.masks = {
	"default":      "ddd mmm dd yyyy HH:MM:ss",
	shortDate:      "m/d/yy",
	mediumDate:     "mmm d, yyyy",
	longDate:       "mmmm d, yyyy",
	fullDate:       "dddd, mmmm d, yyyy",
	shortTime:      "h:MM TT",
	mediumTime:     "h:MM:ss TT",
	longTime:       "h:MM:ss TT Z",
	isoDate:        "yyyy-mm-dd",
	isoTime:        "HH:MM:ss",
	isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss",
	isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
};

// Internationalization strings
dateFormat.i18n = {
	dayNames: [
		"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
		"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
	],
	monthNames: [
		"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
		"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
	]
};

// For convenience...
Date.prototype.format = function (mask, utc) {
	return dateFormat(this, mask, utc);
};