$(document).ready(function() {

    $("form").submit(function (e) {
        if(!($("#rgpd").get(0).checked)){
            if(!confirm("Le non-consentement de la politique de protection des données personnelles peut rendre le dossier Objectif CO2 de votre entreprise impossible à traiter. En effet, les données saisies dans l’outil sont consultées par les services de l’ADEME pour valider les dossiers d’engagement dans la Charte et/ou dans le Label.")){
                e.preventDefault();
            }
        }
    });

});