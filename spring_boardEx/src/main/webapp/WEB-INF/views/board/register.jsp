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
	<style>
		.smalImage {
			width:15px;
			height: auto;
		}
		.uploadResult ul {
			displsy:flex;
			flex-flow:row;
			justify-content: center;
			align-items: center;
		}
		.uploadResult ul li {
			list-style: none;
			padding :10px;
		}
		li div img {
			width:30px;
		}
	</style>
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
                            	<form role="form" action="/board/register" method="post">
                            		<div class="form-group">
                            			<label>Title</label><input class="form-control" name='title'>
                            		</div>
                            		<div class="form-group">
                            			<label>Text area</label>
                            			<textarea class="form-control" rows="3" name='content'></textarea>
                            		</div>
                            		<div class="form-group">
                            			<label>Writer</label><input class="form-control" name='writer'>
                            		</div>
                            		<button type="submit" class="btn btn-default">Submit Button</button>
                            		<button type="reset" class="btn btn-default">Reset Button</button>
                            	</form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">File Attach</h6>
                    </div>
                    <div class="card-body uploadDiv">
                     <div class="form-group">
                     	<label for="files" class="btn btn-primary"><i class='fas fa-paperclip'></i>File</label>
                         <input type="file" class="form-control d-none" id="files" name="uploadFile" multiple>
                    </div>
                   </div>
                   <div class="uploadResult">
						<ul class="list-group">
						</ul>
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
		$(document).ready(function(e){
			var formObj = $("form[role='form']");
			$("button[type='submit']").on("click", function(e){
				e.preventDefault();
				console.log("submit chlicked");
				
				var str="";
				
				$(".uploadResult ul li").each(function(i, obj){
				      
				      var jobj = $(obj);
				      
				      console.dir(jobj);
				      console.log("-------------------------");
				      console.log(jobj.data("filename"));
				      
				      
				      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
				      
				    });
				console.log(str);
				formObj.append(str).submit();
			})
			$(".uploadResult").on("click", "button", function(e){
				console.log("delete file");
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url : '/deleteFile',
					data:{fileName: targetFile, type:type},
					dataType:'text',
					type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove();
					}
				})
			});
		/* 	var formObj = $("form[role='form']");
			
			$("button[type='submit']").on("click", function(e){
				e.preventDefault();
				
				console.log("submit clicked");
			}); */
			
			var regex = new RegExp("(.*?)\.(exp|sh|zip|alz)$");
			var maxSize = 5242880;
			
			function checkExtension(fileName, fileSize){
				if(fileSize > maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			
			 $("input[type='file']").change(function(e){

				    var formData = new FormData();
				    
				    var inputFile = $("input[name='uploadFile']");
				    
				    var files = inputFile[0].files;
				    
				    for(var i = 0; i < files.length; i++){

				      if(!checkExtension(files[i].name, files[i].size) ){
				        return false;
				      }
				      formData.append("uploadFile", files[i]);
				      
				    }
				    function showUploadResult(uploadResultArr){
				    	
				    	if(!uploadResultArr || uploadResultArr.length == 0){return;}
				    	
				    	var uploadUL = $(".uploadResult ul");
				    	
				    	var str = "";
						   
						   $(uploadResultArr).each(function(i, obj){
						     
							   if(obj.image){
									var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/S_"+obj.uuid +"_"+obj.fileName);
									str += "<li data-path='"+obj.uploadPath+"'";
									str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
									str +" ><div>";
									str += "<span> "+ obj.fileName+"</span>";
									str += "<button type='button' data-file=\'"+fileCallPath+"\' "
									str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/display?fileName="+fileCallPath+"'>";
									str += "</div>";
									str +"</li>";
								}else{
									var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
								    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
								      
									str += "<li "
									str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
									str += "<span> "+ obj.fileName+"</span>";
									str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
									str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/resources/img/pngegg.png'></a>";
									str += "</div>";
									str +"</li>";
								}
						   });
						   
						   uploadUL.append(str);
						 }
				$.ajax({
					url:"/uploadAjaxAction",
					processData: false,
					contentType: false,
					data: formData,
					type:'POST',
					dataType:'json',
					success: function(result){
						console.log(result);
						showUploadResult(result);
					}
				});
			});
		});
	</script>
</html>