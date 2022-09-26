$(document).ready(function() {

    $("#rgpd label:first-child").html($("#rgpd label:first-child").text());

    $("form").submit(function (e) {
        if(($("input[name=consentement]:checked").val()) == 0){
            if(!confirm("Le non-consentement de la politique de protection des données personnelles peut rendre le dossier Objectif CO2 de votre entreprise impossible à traiter. En effet, les données saisies dans l’outil sont consultées par les services de l’ADEME pour valider les dossiers d’engagement dans la Charte et/ou dans le Label.")){
                e.preventDefault();
            }
        }
    });
});