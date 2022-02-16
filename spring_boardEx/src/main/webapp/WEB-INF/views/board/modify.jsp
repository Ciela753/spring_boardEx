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
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Board Register</h1>
                            </div>
                            
                            <div class="panel-body">
                            <form method="post">
                           		<div class="form-group">
                           			<label>Bno</label><input class="form-control" name='bno' value='<c:out value="${board.bno}"/>'readonly>
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
                           		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"></c:out>'>
                           		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"></c:out>'>
                           		<button type="submit" fromaction="modify" class="btn btn-default">Modify Button</button>
                           		<button type="submit" formaction="remove" class="btn btn-default">Remove Button</button>
                           		<button type="list" formaction="list" class="btn btn-default">List</button>
                            </form>
                            </div>
                            <!-- File -->
		                    <div class="card shadow mb-4">
		                        <div class="card-header py-3">
		                            <h6 class="m-0 font-weight-bold text-primary">File Attach</h6>
		                        </div>
		                        <div class="uploadDiv">
									<input type='file' id="flies" name='uploadFile' multiple>
								</div>                       
			                   <div class="uploadResult">
									<ul class="list-group">
									</ul>
							   </div>
		                    </div>
                        </div>
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
<script>
$(document).ready(function() {
    
    var bno = '${board.bno}';
    var $ul = $("#replyUL");
   
    $(".uploadResult").on("click", "li", function(e){
   	 console.log("view image");
   	 
   	 var liObj = $(this);
   	 
   	 var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
   	 
   	 if(liObj.data("type")){
   		 showImage(path.replace(new RegExp(/\\/g), "/"));
   	 } else {
   		 self.location = "download?fileName="+path;
   	 }
    });
    
    function showImage(fileCallPath){
   	 alert(fileCallPath);
   	 
   	 $(".bigPictureWrapper").css("display", "flex").show();
   	 
   	 $(".bigPicture")
   	 .html("<img src='/display?fileName="+fileCallPath+"'>")
   	 .animate({width: '100%', height:'100%'}, 1000);
    }
    
	$.getJSON("/board/getAttachList/"+ bno).done(function(data) {
	   	 console.log(data);
	   	 showUploadFile(data);
     })
   
   function showUploadFile(attach) {
		var str = "";
		var fileCallPath = encodeURIComponent(attach.uploadPath+ "/S_"+attach.uuid+"_"+attach.filename);
		for(var i in attach) {
			str +="<li class='list-group-item'";
			str +="data-path='" + attach[i].path + "' ";
			str +="data-uuid='" + attach[i].uuid + "' ";
			str +="data-filename='" + attach[i].fileName + "' ";
			str +="data-type='" + attach[i].fileType + "' ";
			str +="><div>"
			if(attach.fileType){
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str +="</li>";
			} else {
				str += "<span> "+attach[i].fileName+"</span></br>";
				str += "<img src='/resources/img/pngegg.png'>";
				str += "</div>";
				str +="</li>";
			}
			console.log(str);
			$(".uploadResult ul").append(str);
		}
	}
}
)
</script>
</html>