// For highlighting images.
function highlight(img, location, newimg, desc) {
	var imgbase;
	if (document.images) {
		if (newimg) {
			imgbase = newimg;
		} else {
			imgbase = "2bt" + img;
		}
		document.images[img].src = location + imgbase + ".gif";
	}
	if (desc) {
		window.status = desc;
		return true;
	}
}

// For unhighlighting images.
// NOTE: This is kinda redundant with above code, but what the heck...
function unhighlight(img, location, newimg) {
	var imgbase;
	if (document.images) {
		if (newimg) {
			imgbase = newimg;
		} else {
			imgbase = "bt" + img;
		}
		document.images[img].src = location + imgbase + ".gif";
	}
	window.status = "";
	return true;
}
