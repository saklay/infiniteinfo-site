var curScreen = 1;

// Preload some images.
if (document.images) {
	var sub1 = new Image();
	var sub2 = new Image();
	var sub3 = new Image();
	var sub4 = new Image();
	var sub5 = new Image();
	var sub6 = new Image();
	sub1.src = "../../2btenlarge.gif";
	sub2.src = "../../2btnext.gif";
	sub3.src = "../../2btprev.gif";
	sub4.src = "../../dbtenlarge.gif";
	sub5.src = "../../dbtnext.gif";
	sub6.src = "../../btprev.gif"; // Because we start with dbtprev as the default image.
}

// Special highlight function which checks to see if the next or previous buttons are disabled.	
function bthighlight (img) {
	if (img == "enlarge" || (img == "next" && curScreen < maxScreens) || (img == "prev" && curScreen > 1)) {
		highlight(img, '../../');
	}
}

// Special unhighlight function which checks to see if the next or previous buttons are disabled.
function btunhighlight (img) {
	if (img == "enlarge" || (img == "next" && curScreen < maxScreens) || (img == "prev" && curScreen > 1)) {
		unhighlight(img, '../../');
	}
}

// Load the next image in line.
function next() {
	if (curScreen < maxScreens) {
		curScreen++;
		btunhighlight('prev');	// Don't forget to enable the previous button.
		document.images["screen"].src = "screen" + curScreen + ".gif";
		if (curScreen == maxScreens) {
			document.images["next"].src = "../../dbtnext.gif";
		}
	}
}

// Load the previous image in line.
function previous() {
	if (curScreen > 1) {
		curScreen--;
		btunhighlight('next');	// Don't forget to enable the next button.
		document.images["screen"].src = "screen" + curScreen + ".gif";
		if (curScreen == 1) {
			document.images["prev"].src = "../../dbtprev.gif";
		}
	}
}

// Give em the "big picture".
function enlarge() {
	window.open("screen" + curScreen + ".jpg", 'Screenshot', 'height=400,width=550,scrollbars');
}
