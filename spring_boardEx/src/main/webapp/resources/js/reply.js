console.log("reply Module...........")

var replyService = (function() {
	return {name:"AAAA"};
})();

console.log("Reply Module..........");

$(document).ready(function(){
	
})

var replyService = (function() {
	/*function add(reply, callback, error) {
		console.log("add reply.................");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		})
	}*/
	
	function add(reply, callback, error) {
        console.log("reply.add()");
        console.log(reply);

        $.ajax({
            type : "post",
            url : "/replies/new",
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(data) {
                if(callback)
                callback(data);
            },
            error : function(xhr, stat, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }
	
	function getList(param, callback, error) {
		var bno = param.bno;
		
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+bno + "/"+page+".json",
				function(data) {
				if (callback) {
					callback(data);
				}
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/'+rno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		})
	}
	
	function modify(reply, callback, error) {
	    console.log("reply.modify()");
	    var url = '/replies/' + reply.rno;

	    $.ajax(url, {
	        type : "put",
	        data : JSON.stringify(reply),
	        contentType : "application/json; charset=utf-8",
	        success : function(data) {
	            if(callback)
	            callback(data);
	        }        
	    })
	}
	
	function get(rno, callback, error) {
		$.get("/replies/" + rno + ".json", function(result){
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		})
	}
	
	function displayTime(timeValue) {
	    return moment().diff(moment(timeValue), 'days') < 1 ? moment(timeValue).format('HH:mm:ss') : moment(timeValue).format('YY/MM/DD');
	}
	
	return {
		add: add,
		getList : getList,
		remove : remove,
		modify : modify,
		get : get,
		displayTime : displayTime
	};
	
})();