$(document).ready(function() {
    $("#rgpd label:first-child").html($("#rgpd label:first-child").text());

    // on selectionne toutes les options du multiselect contenu_zone au chargement de la page
	var selectZone = document.getElementById("contenu_zone");
    for (var i=0; i< selectZone.options.length; i++) {
        selectZone.options[i].setAttribute("selected", "selected");
    }

    $("form").submit(function (e) {
        if(($("input[name=consentement]:checked").val()) == 0){
            if(!confirm("Le non-consentement de la politique de protection des données personnelles peut rendre le dossier Objectif CO2 de votre entreprise impossible à traiter. En effet, les données saisies dans l’outil sont consultées par les services de l’ADEME pour valider les dossiers d’engagement dans la Charte et/ou dans le Label.")){
                e.preventDefault();
            }
        }
    });
});