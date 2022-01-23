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
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Board Register</h1>
                            </div>
                            
                            <div class="panel-body">
                            <form action="/board/modify" method="post">
                           		<div class="form-group">
                           			<label>Bno</label><input class="form-control" name='Bno' value='<c:out value="${board.bno}"/>'readonly>
                           		</div>
                           		<div class="form-group">
                           			<label>Title</label><input class="form-control" name='title' value='<c:out value="${board.title}"/>'>
                           		</div>
                           		<div class="form-group">
                           			<label>Text area</label>
                           			<textarea class="form-control" rows="3" name='content' ><c:out value="${board.content}"/></textarea>
                           		</div>
                           		<div class="form-group">
                           			<label>Writer</label><input class="form-control" name='writer' value='<c:out value="${board.writer}"/>'readonly>
                           		</div>
                           		<div class="form-group">
                           			<label>RegDate</label>
                           			<input class="form-control" name='regDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/>' readonly>
                           		</div>
                           		<div class="form-group">
                           			<label>Update Date</label>
                           			<input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/>' readonly>
                           		</div>
                           		<button type="submit" oper="modify" class="btn btn-default">Modify Button</button>
                           		<button type="submit" oper="remove" class="btn btn-default">Remove Button</button>
                           		<button type="list" oper="list" class="btn btn-default">List</button>
                            </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

</body>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form");
		
		$('button').on("click", function(e){
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove') {
				formObj.attr("action", "/board/remove");
			}else if(operation === 'list'){
				formObj.attr("action", "/board/list").attr("method", "get"));
				formObj.empty();
			}
			formObj.submit();
		})
	})
</script>
</html>