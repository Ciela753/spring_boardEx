<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Board Register</h1>
                            </div>
                            
                            <div class="panel-body">
                           		<div class="form-group">
                           			<label>Bno</label><input class="form-control" name='Bno' value='<c:out value="${board.bno}"/>' readonly>
                           		</div>
                           		<div class="form-group">
                           			<label>Title</label><input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly>
                           		</div>
                           		<div class="form-group">
                           			<label>Text area</label>
                           			<textarea class="form-control" rows="3" name='content' readonly><c:out value="${board.content}"/></textarea>
                           		</div>
                           		<div class="form-group">
                           			<label>Writer</label><input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly>
                           		</div>
                           		<button oper='modify' class="btn btn-default">Modify Button</button>
                           		<button oper='list' class="btn btn-default">List</button>
                           		<form action="/board/modify" method="get" id="operForm">
                           			<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                           			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"></c:out>'>
                           			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"></c:out>'>
                           		</form>
                            </div>
                            <div class="card shadow mb-4">
                            <div class="card-header py-3 clearfix">
                                <h6 class="m-0 font-weight-bold text-primary"><i class="fa fa-comments">Reply</i></h6>
                                <button class="btn btn-primary float-right btn-sm" id="btnRegfrm">New Reply</button>
                            </div>                                                               
                                <ul id="replyUL" class="list-group list-group-flush">                                	                                
                                </ul>
                                <div class="card-footer text-center">
                                	<button class="btn btn-primary btn-block"id="btnShowMore">더보기</button>                                	
                                </div>
                            </div>
                		</div>
    					</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<!-- List Modal-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">ReplyModal</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="reply" class="text-dark font-weight-bold">Reply</label>
                    <input class="form-control" id="reply" name="reply" placeholder="new Reply!!">
               </div>
               <div class="form-group">
                    <label for="reply" class="text-dark font-weight-bold">Replyer</label>
                    <input class="form-control" id="replyer" name="replyer" placeholder="Replyer!!">
               </div>
               <div class="form-group">
                    <label for="reply" class="text-dark font-weight-bold">Reply</label>
                    <input class="form-control" id="replyDate" name="replyDate" placeholder="">
               </div>
            </div>
            <div class="modal-footer text-right">
                <div class="btns">
                    <button class="btn btn-primary" id="btnReg">Register</button>
                    <button class="btn btn-warning" id="btnMod">Modify</button>
                    <button class="btn btn-danger" id="btnRmv">Remove</button>
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>	

    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>

</body>
<script src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	console.log(replyService);
	
	$("#btnRegfrm").click(function() {
		$("#myModal").find("input").val("");
        $("#replyDate").closest("div").hide();
        $(".btns button").hide()
        $("#btnReg").show();
        $("#myModal").modal("show");
    })
    
     var bno = '${board.bno}';
     var $ul = $("#replyUL");
    
     $("#btnReg").click(function() {
            
            var reply = {reply: $("#reply").val(), replyer:$("#replyer").val(), bno:bno};
            replyService.add(reply,                
                function(data) {
                    alert(data)
                    var count = $ul.find("input").length;
                    $ul.html("");
                    $("#myModal").find("input").val("");
                    $("#myModal").modal("hide");
                    showList(1);
                    
                    function showList(lastRno, amount) {
                        replyService.getList({bno:bno, lastRno:lastRno, amount:amount},
                         function(data) {
                            console.log(data)
                             if(!data) {
                                 return;
                             }
                             if(data.length == 0) {
                                $("#btnShowMore").text("댓글이 없습니다.").prop("disabled", true);
                                return;
                             }
                             var str ="";
                             for(var i in data) {
                                 str +=' <li class="list-group-item" data-rno="'+data[i].rno+'">'
                                 str +='    <div class="clearfix">'
                                 str +='        <div class="float-left text-dark font-weight-bold">'+data[i].replyer+'</div>'
                                 str +='            <div class="float-right">'+replyService.displayTime(data[i].replyDate)+'</div>'
                                 str +='        </div>'
                                 str +='        <div>'+data[i].reply+'</div>'
                                 str +='</li>'
                             }
                             $("#btnShowMore").text("더보기").prop("disabled", false);
                             $ul.append(str);
                             console.log(amount);
                           }
                        )
                    }
                    
                    
                }
            );
        })
        
    $ul.on("click", "li", function(){
    	var rno = $(this).data("rno");
    	replyService.get(rno, function(data){
    		$("#reply").val(data.reply);
    		$("#replyer").val(data.replyer);
    		$("#replyDate").val(replyService.displayTime(data.replyDate)).prop("readonly", true).closest("div").show();
    		$(".btns button").hide();
    		$("#btnMod, #btnRmv").show();
    		$("#myModal").data("rno", data.rno).modal("show");
    	}); 
    })
        
    $('#btnRmv').click(function(){
    	var rno = $("#myModal").data("rno");
    	replyService.remove(rno, function(data){
    		alert(data);
    		$("#myModal").modal("hide");
    		$ul.find("li").each(function(){
    			if($(this).data("rno") === rno) {
    				$(this).remove();
    			}
    		})
    	})
    });
    
     $("#btnMod").click(function(){
              var reply = {reply: $("#reply").val(), rno:$("#myModal").data("rno"), replyer:$("#replyer").val()};
              replyService.modify(reply,                
                  function(data) {
                      alert(data)
                      $("#myModal").modal("hide");
                      $ul.find()
                      showList(1);
                 
                  })
          })
});
console.log("================");
console.log("JS Test");
var bnoValue = '<c:out value="${board.bno}"/>';
/* replyService.remove(23, function(count) {
	console.log(count);
	
	if(count === "success") {
		alert("removed");
	}
}, function(err) {
	alert('Error...');
});
replyService.update({
	rno : 22,
	bno : bnoValue,
	reply : "Modified Reply...."
}, function(result){
	alert("수정 완료...");
});
replyService.get(10, function(data){
	console.log(data);
})
replyService.getList({bno:bnoValue, page:1}, function(list){
	for(var i=0, len= list.length||0; i<len; i++) {
		console.log(list[i]);
	}
});
replyService.add(
	{reply:"ts Test", replyer:"tester", bno:bnoValue}
	,
	function(result){
		alert("RESULT: result");
	}
);
 */
$(document).ready(function(){
	var operForm = $("#operForm");
	
	$("button[oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();	
	});
	$("button[oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();	
	});
});
$(function() {
	console.log(replyService);
    var bno = '${board.bno}';
    var $ul = $("#replyUL");
    showList();
    function showList(lastRno, amount) {
        replyService.getList({bno:bno, lastRno:lastRno, amount:amount},
         function(data) {
            console.log(data)
             if(!data) {
                 return;
             }
             if(data.length == 0) {
                $("#btnShowMore").text("댓글이 없습니다.").prop("disabled", true);
                return;
             }
             var str ="";
             for(var i in data) {
                 str +=' <li class="list-group-item" data-rno="'+data[i].rno+'">'
                 str +='    <div class="clearfix">'
                 str +='        <div class="float-left text-dark font-weight-bold">'+data[i].replyer+'</div>'
                 str +='            <div class="float-right">'+replyService.displayTime(data[i].replyDate)+'</div>'
                 str +='        </div>'
                 str +='        <div>'+data[i].reply+'</div>'
                 str +='</li>'
             }
             $("#btnShowMore").text("더보기").prop("disabled", false);
             $ul.append(str);
             console.log(amount);
           }
        )
    }
});
</script>
</html>