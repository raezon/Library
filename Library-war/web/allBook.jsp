<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Accueil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#03a6f3">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
</head>

<body>
    <header>

        <div class="main-menu">
            <div class="container">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="navbar-brand" href="index.html"><img src="assets/images/logo.png" alt="logo"></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ml-auto">
                            <li class="navbar-item active">
                                <a href="index.jsp" class="nav-link">Acceuil</a>
                            </li>
                            <li class="navbar-item">
                                <a href="allBook.jsp" class="nav-link">Tous nos Livres</a>
                            </li>
                            <li class="navbar-item">
                                <a href="about_us.jsp" class="nav-link">À propos de nous</a>
                            </li>
                         
                            <li class="navbar-item">
                                <a href="Login.jsp" class="nav-link">Authentification</a>
                            </li>
                        </ul>
                        <form class="form-inline my-2 my-lg-0" method="post" action="Search_acceuil">
                            
                            <input class="form-control mr-sm-2" type="search" name="query" placeholder="Chercher ici..." aria-label="Search">
                            <span class="fa fa-search" data-target="#Popup" data-toggle="modal"></span>
                        </form>
                    </div>
                </nav>
            </div>
        </div>
    </header>
    <section class="slider">
        <div class="container hero">
            <form method="post" action="Search">
              
                    <div class="col-sm-12 col-offset-2">
                        <input class="border rounded border-primary shadow-lg form-control d-inline-block" type="text" name="query" data-bs-hover-animate="pulse"
                            style="width: 300px;">
                        <div class="dropdown d-inline-block">
                            <select name="t" class="btn btn-primary dropdown-toggle bg-dark d-inline-block" data-toggle="dropdown" aria-expanded="false" type="button" data-bs-hover-animate="pulse" style="margin: 20px;margin-top: 15px;"><option value="titre" >Par Titre</option><option value="domaine" >Par Domaine</option><option value="nom" >Par Auteur</option></select>
                        </div>
                        <input class="btn btn-info bg-info" type="submit" data-bs-hover-animate="pulse" style="margin-top: -6px;" value="Rechercher">
                    </div>
                
            </form>
        </div>
    </section>
    <section class="recent-book-sec">
        <div class="container">
            <div class="title">
                <h2>Tous nos livres</h2>
                <hr>
            </div>
           <div class="row">
            
            <%@ page import="java.io.*" %>
            <%@ page import="javax.servlet.*" %>
            <%@ page import="javax.servlet.http.*" %>
            <%@ page import="java.sql.*" %>
            
            <%
                Object o1=request.getAttribute("query");
                Object o2=request.getAttribute("t");
                
                String a=String.valueOf(o1);
                String b=String.valueOf(o2);
                if(o1==null)
                {
                String titre="init";
                String domaine="init";
                String nom_auteur="init";
                String prenom_auteur="init";
                String image="init";
                String name="";
                String id="";

            
                Statement st = null;
                Class.forName("com.mysql.jdbc.Driver");
                Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                st=c.createStatement();
                int n=0;
                ResultSet myrs = st.executeQuery("select issn,titre,domaine,nom,prenom,image from livre,author where num_auteur=num");
                while(myrs.next()){ 
                    titre=myrs.getString("titre");
                    domaine=myrs.getString("domaine");
                    nom_auteur=myrs.getString("nom");
                    prenom_auteur=myrs.getString("prenom");
                    image=myrs.getString("image"); 
                    name=nom_auteur+" "+prenom_auteur;
                    id=myrs.getString("issn");

               
                    %>
                    
                    <% if(n==3)
                    { n=0; %>
                        </div>
                        <hr style="margin: 1px;">
                    <div class="row" >
                          <% } %>
                    <div class="col-lg-2 col-md-3 col-sm-4">
                        <div class="item">
                              <img src="assets/img/<%= image %>" style="width: 150px;height: 235px;">
                              <label class="d-block" style="font-size: 18px;"><strong><%= titre %></strong></label>
                              <h6><button class="btn btn-primary" name="affiche" id="<%= id %>" type="submit" >Visioner</button></h6>
                          
                        </div>   
                    </div>
                <br>
                
                <% n++; }}%>
                
                <% if(o1!=null)
                {
                 String titre="init";
                String domaine="init";
                String image="init";
                String nom_auteur="init";
                String prenom_auteur="init";
                String name="";
                String id="";
                Statement st = null;
                Class.forName("com.mysql.jdbc.Driver");
                Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                st=c.createStatement();
                int n=0;
                
                ResultSet myrs = st.executeQuery("select issn,titre,domaine,nom,prenom,image from livre,author where num_auteur=num AND "+b+"='"+a+"'");
                              
                
                while(myrs.next()){ 
                    titre=myrs.getString("titre");
                    domaine=myrs.getString("domaine");
                    nom_auteur=myrs.getString("nom");
                    prenom_auteur=myrs.getString("prenom");
                    image=myrs.getString("image"); 
                    name=nom_auteur+" "+prenom_auteur;
                    id=myrs.getString("issn");
                %>
                
                
                <% if(n==3)
                    { n=0; %>
                        </div>
                        <hr style="margin: 1px;">
    <div class="row text-center" style="background-color: rgba(255,255,255,0.96);">
                    <% } %>
                    
                    <div class="col" style="width: 180px;padding: 20px;"><button class="btn btn-primary" name="affiche" id="<%= id %>" type="submit" style="background-color: rgba(255,255,255,0);"><img src="assets/img/<%= image %>" style="width: 150px;height: 235px;"></button>
                <hr style="height: 1px;background-color: #fe0000;"><label class="d-block" style="color: rgb(0,0,0);font-size: 16px;"><%= name %><br></label><label class="d-block"><%= domaine %></label><a class="af" href="" id="<%= id %>" ><label class="d-block" style="font-size: 18px;"><strong><%= titre %></strong></label></a></div>
                <br>

                <% n++; }}%>
                  
            </div>

            </div>
            
            <div class="btn-sec">
                <a href="#" class="btn gray-btn">visioner tous les livres</a>
            </div>
        </div>
    </section>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="address">
                        <h4>Our Address</h4>
                        <h6>The BookStore Theme, 4th Store
                        Beside that building, USA</h6>
                        <h6>Call : 800 1234 5678</h6>
                        <h6>Email : info@bookstore.com</h6>
                    </div>
                    <div class="timing">
                        <h4>Timing</h4>
                        <h6>Mon - Fri: 7am - 10pm</h6>
                        <h6>??Saturday: 8am - 10pm</h6>
                        <h6>?Sunday: 8am - 11pm</h6>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="navigation">
                        <h4>Navigation</h4>
                        <ul>
                            <li><a href="index.html">Acceuil</a></li>
                            <li><a href="about.html">À propos de nous</a></li>
                            <li><a href="privacy-policy.html">
                                Politique de confidentialité</a></li>
                            <li><a href="terms-conditions.html">Conditions</a></li>
                            <li><a href="products.html">Livres</a></li>
                        </ul>
                    </div>
                    <div class="navigation">
                        <h4>Help</h4>
                        <ul>
                            <li><a href="">Shipping & Returns</a></li>
                            <li><a href="privacy-policy.html">Privacy</a></li>
                            
                        </ul>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="form">
                        <h3>Quick Contact us</h3>
                        <h6>We are now offering some good discount 
                            on selected books go and shop them</h6>
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <input placeholder="Name" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="email" placeholder="Email" required>
                                </div>
                                <div class="col-md-12">
                                    <textarea placeholder="Messege"></textarea>
                                </div>
                                <div class="col-md-12">
                                    <button class="btn black">Alright, Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="copy-right">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>(C) 2017. All Rights Reserved. BookStore Wordpress Theme</h5>
                    </div>
                    <div class="col-md-6">
                        <div class="share align-middle">
                            <span class="fb"><i class="fa fa-facebook-official"></i></span>
                            <span class="instagram"><i class="fa fa-instagram"></i></span>
                            <span class="twitter"><i class="fa fa-twitter"></i></span>
                            <span class="pinterest"><i class="fa fa-pinterest"></i></span>
                            <span class="google"><i class="fa fa-google-plus"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/custom.js"></script>
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