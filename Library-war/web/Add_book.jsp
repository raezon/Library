<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Ajouter Livre</title>
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
    <script>
        function surligne(champ, erreur)
        {
           if(erreur)
              champ.style.backgroundColor = "#fff";
           else
              champ.style.backgroundColor = "";
        }
        function verif(champ)
        {
           var nom = champ.value;
           if(nom==null)
           {
              surligne(champ, true);
              return false;
           }
           else
           {
              surligne(champ, false);
              return true;
           }
        }
        function verifForm(f)
        {
            var titreOk = verif(f.titre);
            

            if(titreoOk)
               return true;
            else
            {
               alert("Veuillez remplir correctement tous les champs");
               return false;
            }
         }
    </script>
</head>

<body>
    <div id="home">
        <div class="text-center header-blue">
            <nav class="navbar navbar-light navbar-expand d-inline-block" style="padding-bottom: 0px;">
                <div class="container-fluid"><a class="navbar-brand shadow-lg" href="#" style="font-size: 27px;"><i class="fa fa-leanpub" style="margin: 10px;"></i><strong>Library-EE</strong><br></a><button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-2"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                    <div
                        class="collapse navbar-collapse text-center d-inline-block" id="navcol-2">
                        <c:if test="${!empty sessionScope.nom }">
                        <ul class="nav navbar-nav"></ul><button class="btn btn-primary" type="button" style="background-color: rgba(0,123,255,0);font-size: 22px;margin-left: 25px;"><i class="fa fa-user" style="font-size: 25px;margin-right: 10px;"></i>Welcome ${ sessionScope.nom } !</button></div>
                        </c:if>
                </div>          
        </nav>
        <hr style="height: 1px;background-color: #ffffff;">
        <div class="col text-center"><label class="border rounded shadow-lg" style="background-color: #ffbd39;padding: 20px;font-size: 22px;font-family: 'Abril Fatface', cursive;">Ajouter Livre</label>
            <hr style="height: 1px;background-color: #ffffff;width: 250px;">
        </div>
        <div class="container hero">
            <form method="post" action="${pageContext.request.contextPath}/Addbook" encType="multipart/form-data"onsubmit="return verifForm(this)">
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-right" style="padding: 0px;"><label onblur="verif(this)" class="col-form-label" style="background-color: rgba(255,255,255,0.96);padding-right: 20px;padding-left: 20px;font-size: 18px;margin: 5px; ">Le Titre du Livre :</label></div>
                    <div class="col"><input class="form-control" type="text" name="titre" style="margin: 5px;width: 300px;"></div>
                </div>
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-right" style="padding: 0px;"><label class="col-form-label" style="background-color: rgba(255,255,255,0.96);padding-right: 20px;padding-left: 20px;font-size: 18px;margin: 5px;">Le nombre de page du Livre :</label></div>
                    <div class="col"><input class="form-control" type="text" name="nbrpage" style="margin: 5px;width: 300px;"></div>
                </div>
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-right" style="padding: 0px;"><label class="col-form-label" style="background-color: rgba(255,255,255,0.96);padding-right: 20px;padding-left: 20px;font-size: 18px;margin: 5px;">Le Domaine du Livre :</label></div>
                    <div class="col"><input class="form-control" type="text" name="domaine" style="margin: 5px;width: 300px;"></div>
                </div>
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-right" style="padding: 0px;"><label class="col-form-label" style="background-color: rgba(255,255,255,0.96);padding-right: 20px;padding-left: 20px;font-size: 18px;margin: 5px;">L'auteur du Livre :</label></div>
                    <div class="col">
                                <div class="dropdown"><select name="auteur" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false" type="button" data-bs-hover-animate="pulse" style="background-color: #4b4c4d;margin-top: 6px;">
                            
                <%@ page import="java.io.*" %>
                <%@ page import="javax.servlet.*" %>
                <%@ page import="javax.servlet.http.*" %>
                <%@ page import="java.sql.*" %>
                    <%
                    
                    String titre="init";
                    String domaine="init";
                    String auteur="init";
                    String image="init";

                    Statement st = null;
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                    st=c.createStatement();
                    //int n=0;
                    String nom_auteur;
                    String prenom_auteur;
                    String name;
                    int num;
                    ResultSet myrs = st.executeQuery("select * from author order by nom asc");
                    while(myrs.next()){ 
                        nom_auteur=myrs.getString("nom");
                        prenom_auteur=myrs.getString("prenom");
                        name=nom_auteur+" "+prenom_auteur;
                        num=Integer.valueOf(myrs.getString("num"));

                    %>
                                
                    
                    <option value="<%= num %>"><%= name %></option>
                            
                            
                    <% } %>  
                         </select>
                        <a class="btn btn-primary bg-success" role="button" href="Add_Author.jsp" style="margin-top:6px"><i class="fa fa-plus"></i></a>
                        </div>
                    </div>
                </div>
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-right" style="padding: 0px;"><label class="col-form-label" style="background-color: rgba(255,255,255,0.96);padding-right: 20px;padding-left: 20px;font-size: 18px;margin-right: 5px;">L'image du Livre :</label></div>
                    <div class="col"><input name="img" type="file" class="btn btn-warning" data-bs-hover-animate="pulse" style="margin-left: 5px;"/></div>
                </div>
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-right" style="padding: 0px;"><label class="col-form-label" style="background-color: rgba(255,255,255,0.96);padding-right: 20px;padding-left: 20px;font-size: 18px;margin: 5px;">Le Résumé du Livre :</label></div>
                    <div class="col"><textarea class="form-control" name="resume" style="margin-left: 5px;height: 100px;width: 300px;"></textarea></div>
                </div>
                <div class="form-row" style="margin: 10px;">
                    <div class="col text-center"><button class="btn btn-success" type="submit" style="width: 150px;margin: 50px;">Ajouter</button></div>
                </div>
            </form>
        </div>
    </div>
    </div>
    <div class="footer-basic" style="padding: 10px;background-color: rgba(255,255,255,0);">
        <footer>
            <div class="social" style="padding: 0px;"><a href="http://instagram.com" target="_blank"><i class="icon ion-social-instagram"></i></a><a href="http://twitter.com" target="_blank"><i class="icon ion-social-twitter"></i></a><a href="http://facebook.com" target="_blank"><i class="icon ion-social-facebook"></i></a></div>
            <p
                class="copyright" style="color: #4b4c4d;"> Ratiba© 2020</p>
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