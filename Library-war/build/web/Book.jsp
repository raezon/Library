<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Livre</title>
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
</head>

<body>
    <%@ page import="java.io.*" %>
    <%@ page import="javax.servlet.*" %>
    <%@ page import="javax.servlet.http.*" %>
    <%@ page import="java.sql.*" %>
     <%  //l'identifiant id du livre cliker 
        String id = request.getParameter("id");
        String titre="init";
        String domaine="init";
        String nom_auteur="init";
        String prenom_auteur="init";
        String image="init";
        String name="";
        String nbrpage="";
        String resume="";
        
        
        Statement st = null;
        Class.forName("com.mysql.jdbc.Driver");
        Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
        st=c.createStatement();
        ResultSet myrs = st.executeQuery("select titre,nbrpage,domaine,resume,nom,prenom,image from livre,author where num_auteur=num AND issn = '"+id+"' limit 1");
        while(myrs.next()){ 
            titre=myrs.getString("titre");
                    domaine=myrs.getString("domaine");
                    nom_auteur=myrs.getString("nom");
                    prenom_auteur=myrs.getString("prenom");
                    image=myrs.getString("image"); 
                    nbrpage=myrs.getString("nbrpage"); 
                    resume=myrs.getString("resume"); 
                    name=nom_auteur+" "+prenom_auteur;
            
        }
     
     
     %>
    <div id="home">
        <div class="text-center header-blue">
            <nav class="navbar navbar-light navbar-expand d-inline-block" style="padding-bottom: 0px;">
                <div class="container-fluid"><a class="navbar-brand shadow-lg" style="font-size: 27px;"><i class="fa fa-leanpub" style="margin: 10px;"></i><strong>Library-EE</strong><br></a><button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-2"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                    <div
                        class="collapse navbar-collapse text-center d-inline-block" id="navcol-2">
                        <ul class="nav navbar-nav"></ul>
                        
                        <c:if test="${empty sessionScope.nom }">
                        <a class="btn btn-primary bg-info border rounded shadow-lg" role="button" href="Login.jsp" data-bs-hover-animate="pulse">Se Connecter</a>
                        </c:if>
                            
                          
                        <c:if test="${!empty sessionScope.nom }">
                            <button class="btn btn-primary" type="button" style="background-color: rgba(0,123,255,0);font-size: 22px;margin-left: 25px;"> <i class="fa fa-user" style="font-size: 25px;margin-right: 10px;"></i>
                            Welcome ${ sessionScope.nom } !</button></div>
                        </c:if>
                        
                        <c:if test="${!empty sessionScope.nom }">
                        <form method="POST" action="deconnect">
                        <button type="submit" style="margin-left: 40px;" class="btn btn-primary bg-danger border rounded shadow-lg" role="button" href="deconnect.java" data-bs-hover-animate="pulse">Déconnecter</button>
                        </form>
                        </c:if>
        </div>
        </nav>
        <hr style="height: 1px;background-color: #ffffff;">
        <div class="container hero">
            <div class="row text-center" style="background-color: rgba(255,255,255,0.96);">
                <div class="col" style="padding: 20px;"><button class="btn btn-primary" type="button" style="background-color: rgba(255,255,255,0);"><img class="d-inline-block" src="assets/img/<%=image %>"></button><a href="#"></a></div>
                <div class="col text-left" style="padding: 20px;"><label class="d-block" style="font-size: 26px;"><strong><%=titre %></strong><br></label>
                    <hr style="height: 1px;background-color: #9a2b2b;">
                    <div><label style="font-size: 23px;">Nombre de page :&nbsp;</label><label style="font-size: 23px;"><%=nbrpage %></label></div>
                    <div><label style="font-size: 23px;">Domaine :&nbsp;</label><label style="font-size: 23px;"><%=domaine %></label></div>
                    <div><label style="font-size: 23px;">Auteur :&nbsp;</label><label style="font-size: 23px;"><%=name %></label></div>
                    <div class="text-center">
                        <hr style="height: 1px;background-color: #9a2b2b;"><label style="font-size: 23px;">Résumé</label></div>
                    <div>
                        <p class="text-break" style="color: #000000;font-family: 'Source Sans Pro', sans-serif;"><%=resume %></p>
                    </div>
                </div>
            </div>
            <hr style="margin: 1px;">
            <hr style="margin: 1px;">
        </div>
    </div>
    </div>
    <div class="footer-basic" style="padding: 10px;background-color: rgba(255,255,255,0);">
        <footer>
            <div class="social" style="padding: 0px;"><a href="http://instagram.com" target="_blank"><i class="icon ion-social-instagram"></i></a><a href="http://twitter.com" target="_blank"><i class="icon ion-social-twitter"></i></a><a href="http://facebook.com" target="_blank"><i class="icon ion-social-facebook"></i></a></div>
            <p
               class="copyright" style="color: #4b4c4d;">Ratiba© 2020</p>
        </footer>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/Animated-Type-Heading.js"></script>
    <script src="assets/js/bs-animation.js"></script>
    <script src="assets/js/Header-Blue--Sticky-Header--Smooth-Scroll-1.js"></script>
    <script src="assets/js/Header-Blue--Sticky-Header--Smooth-Scroll.js"></script>
</body>

</html>