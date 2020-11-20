<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Accueil</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abril+Fatface">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Aclonica">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Acme">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700">
    <link rel="stylesheet" href="assets/css/-Login-form-Page-BS4-.css">
    <link rel="stylesheet" href="assets/css/Animated-Type-Heading.css">
    <link rel="stylesheet" href="assets/css/Footer-Basic.css">
    <link rel="stylesheet" href="assets/css/Header-Blue--Sticky-Header--Smooth-Scroll.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>

<body>
    <div id="home">
        <div class="text-center header-blue">
            <nav class="navbar navbar-light navbar-expand d-inline-block" style="padding-bottom: 0px;">
                <div class="container-fluid"><a class="navbar-brand shadow-lg" href="Home_admin.jsp" style="font-size: 27px;"><i class="fa fa-leanpub" style="margin: 10px;"></i><strong>Library-EE</strong><br></a><button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-2"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                    <div
                        class="collapse navbar-collapse text-center d-inline-block" id="navcol-2">
                        <c:if test="${!empty sessionScope.nom }">
                        <ul class="nav navbar-nav"></ul><button class="btn btn-primary" type="button" style="background-color: rgba(0,123,255,0);font-size: 22px;margin-left: 25px;"><i class="fa fa-user" style="font-size: 25px;margin-right: 10px;"></i>Welcome ${ sessionScope.nom } !</button></div>
                        </c:if>
                        <c:if test="${!empty sessionScope.nom }">
                        <form method="POST" action="deconnect">
                        <input type="submit" style="margin-left: 40px;" class="btn btn-primary bg-danger border rounded shadow-lg" role="button" href="deconnect.java" data-bs-hover-animate="pulse" value="Déconnecter" />
                        </form>
                        </c:if>
                </div>
        </nav>
        <hr style="height: 1px;background-color: #ffffff;">
        <div class="container hero">
            <div class="row">
                <div class="col text-center" style="background-color: rgba(255,255,255,0.3);margin-bottom: 25px;"><a class="btn btn-primary bg-info" role="button" href="Add_Author.jsp" data-bs-hover-animate="pulse" style="margin: 20px;">Ajouter Auteur</a><a class="btn btn-primary bg-info" role="button" href="Add_book.jsp" data-bs-hover-animate="pulse"
                        style="margin: 20px;">Ajouter Livre</a></div>
            </div>
            </div>
            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/bootstrap/js/bootstrap.min.js"></script>
            <script src="assets/js/Animated-Type-Heading.js"></script>
            <script src="assets/js/bs-animation.js"></script>
            <script src="assets/js/Header-Blue--Sticky-Header--Smooth-Scroll-1.js"></script>
            <script src="assets/js/Header-Blue--Sticky-Header--Smooth-Scroll.js"></script>
</body>
<script>
    
    $(document).ready(function(){
      
      $('button').click(function(){ 
          id=$(this).attr("id");
           $.ajax({
            url:"Book.jsp",
            method:"post",
            data:{id:id},
            success:function(data)
            {
              document.location.href="Book.jsp?id="+id;
            }
          });
      });
        
});

  
    
</script>
<script>
    
    $(document).ready(function(){
      
      $('.af').click(function(){ 
          id=$(this).attr("id");
           $.ajax({
            url:"Book.jsp",
            method:"post",
            data:{id:id},
            success:function(data)
            {
              document.location.href="Book.jsp?id="+id;
            }
          });
      });
        
});

  
    
</script>

</html>