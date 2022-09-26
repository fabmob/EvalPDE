<?php
/**
 * Formulaire pour démarrer l'inscription avec l'email (page d'accueil)
 */
class Ademe_Form_Modules_Inscription_RGPD extends Ademe_Form_Form
{
    public function init()
    {
        parent::init();

        // Ajout du RGPD
        $this->addElement(
            'checkbox',
            'rgpd',
            array(
                'required'   => false,
                'value' => 'accept',
                'label'		=> 'J\'accepte la politique de <a href="https://www.ademe.fr/politique-protection-donnees-personnelles" target="_blank">protection des données personnelles</a> de l\'ADEME.', // #17237
                'decorators' => array(
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(array('placement' => 'pend')),
                    new Zend_Form_Decorator_HtmlTag(array('tag' => 'div', 'class' => 'champs enabled'))
                ),
            )
        );

        $this->addElement(
            'submit',
            'continuer',
            array(
                'required'          => false,
                'ignore'            => true,
                'label'             => 'Continuer',
                'class'             => 'button-right',
                'decorators'        => array(
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Submit(),
                    array('decorator' => array("conteneur" => "HtmlTag"), 'options' => array('tag' => 'div', 'class' => 'bloc_champs')),
                )
            )
        );

        $this->removeDecorator('Ademe_Form_Decorator_ChampsObligatoires');
    }
}
