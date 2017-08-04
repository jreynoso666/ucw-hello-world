function displayImage() {
    var content = $("#content-img");
    $.ajax({url: "get-image",
	    data: {"type": this.statusgoal},
	    cache: false,
	    type: "post",
	    success: function(result){
		content.html(result);
	    },
	    error: function(xhrm, status){

	    }
	   });
}



